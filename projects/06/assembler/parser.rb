# frozen_string_literal: true

class Parser
  def initialize(file, symbol_table = SymbolTable.new)
    @file = file
    @symbol_table = symbol_table
    @commands = []
  end

  def parse
    advance while has_more_commands?

    resolve_symbol_address

    @commands
  end

  def has_more_commands?
    !@file.eof?
  end

  def advance
    line = remove_spaces_and_comment(@file.readline.chomp)
    return if line.empty?

    command = parse_command(line)

    process_symbol(command)

    @commands << command unless command.is_a?(LCommand)
  end

  def parse_command(command)
    [ACommand, LCommand, CCommand].each do |command_class|
      matched = command_class::PATTERN.match(command)
      return command_class.new(matched) if matched
    end

    raise "[Parser error]: Failed to parse command line '#{command}'"
  end

  private

  def resolve_symbol_address
    @commands.each do |command|
      next unless command.is_a?(ACommand) && command.address.nil?

      command.address = @symbol_table.fetch(command.symbol)
    end
  end

  def remove_spaces_and_comment(line)
    line.gsub(%r{//.*}, '').strip
  end

  def process_symbol(command)
    case command
    when ACommand
      @symbol_table.add_variable(command.symbol) if command.symbol
    when LCommand
      @symbol_table.write_label(command.symbol, @commands.size)
    end
  end

  class ACommand
    PATTERN = /@([\w.$]+)/

    attr_reader :symbol
    attr_accessor :address

    def initialize(matched)
      value = matched[1]
      if symbol?(value)
        @symbol = value
      else
        @address = Integer(value)
      end
    end

    private

    def symbol?(str)
      str.start_with?(/[a-zA-Z]/)
    end
  end

  class LCommand
    PATTERN = /\(([\w.$]+)\)$/

    attr_reader :symbol

    def initialize(matched)
      @symbol = matched[1]
    end
  end

  class CCommand
    PATTERN = /(?:(\w+)=)?([\w+\-!&|]+)(?:;(\w+))?$/

    attr_reader :dest, :comp, :jump

    def initialize(matched)
      @dest = matched[1]
      @comp = matched[2]
      @jump = matched[3]
    end
  end
end
