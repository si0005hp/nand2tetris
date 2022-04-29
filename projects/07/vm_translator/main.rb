# frozen_string_literal: true

require './parser'

if ARGV.empty?
  puts '[ERROR]: no input files'
  exit 1
end

input_file_path = ARGV.first

File.open(input_file_path, 'r') do |in_file|
  parser = Parser.new(in_file)

  parser.advance while parser.has_more_commands?
end
