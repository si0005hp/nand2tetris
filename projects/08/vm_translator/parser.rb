# frozen_string_literal: true

class Parser
  attr_reader :command, :arg1, :arg2

  def initialize(file)
    @file = file
  end

  def has_more_commands?
    !@file.eof?
  end

  def advance
    line = remove_spaces_and_comment(@file.readline.chomp)
    return false if line.empty?

    parse_line(line)
    true
  end

  private

  def parse_line(line)
    matched = /(\w+)(?: (\w+))?(?: (\w+))?$/.match(line)
    raise "[Parser error]: Failed to parse line '#{line}'" unless matched

    @command = matched[1]
    @arg1 = matched[2]
    @arg2 = matched[3]
  end

  def remove_spaces_and_comment(line)
    line.gsub(%r{//.*}, '').strip
  end
end
