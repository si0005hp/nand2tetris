# frozen_string_literal: true

class Parser
  attr_reader :command_type, :arg1, :arg2

  def initialize(file)
    @file = file
  end

  def has_more_commands?
    !@file.eof?
  end

  def advance
    line = remove_spaces_and_comment(@file.readline.chomp)
    return if line.empty?

    parse_line(line)
  end

  private

  def parse_line(line)
    matched = /(\w+)(?: (\w+))?(?: (\w+))?$/.match(line)
    raise "[Parser error]: Failed to parse line '#{line}'" unless matched

    @command_type = parse_command_type(matched[1])
    @arg1 = matched[2]
    @arg2 = matched[3]
  end

  def remove_spaces_and_comment(line)
    line.gsub(%r{//.*}, '').strip
  end

  def parse_command_type(command) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    case command
    when 'add' || 'sub' || 'neq' || 'eq' || 'gt' || 'lt' || 'and' || 'or' || 'not'
      'C_ARITHMETIC'
    when 'push'
      'C_PUSH'
    when 'pop'
      'C_POP'
    else
      raise "[Parser error]: Invalid command type '#{command}'"
    end
  end
end
