# frozen_string_literal: true

require './parser'
require './symbol_table'
require './code'

if ARGV.empty?
  puts '[ERROR]: no input files'
  exit 1
end

input_file_path = ARGV.first

File.open(input_file_path, 'r') do |in_file|
  parser = Parser.new(in_file)
  commands = parser.parse

  if ARGV[1] == '-ot'
    # Out to terminal
    commands.each { |command| puts Code.dump(command) }
  else
    output_file_path = input_file_path.gsub(/\.asm$/, '.hack')
    File.open(output_file_path, 'w') do |out_file|
      commands.each { |command| out_file.write("#{Code.dump(command)}\n") }
    end
  end
end
