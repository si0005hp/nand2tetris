# frozen_string_literal: true

require './parser'
require './code_writer'

if ARGV.empty?
  puts '[ERROR]: no input files'
  exit 1
end

input_path = ARGV.first

output_file_path, input_file_paths =
  if input_path.end_with?('.vm')
    # input is file
    [input_path.gsub(/\.vm$/, '.asm'),
     [input_path]]
  else
    # input is directory
    ["#{input_path}/#{File.basename(input_path)}.asm",
     Dir.glob("#{input_path}/**").select { |path| path.end_with?('.vm') }]
  end

File.open(output_file_path, 'w') do |out_file|
  writer = CodeWriter.new(out_file)

  input_file_paths.each do |path|
    File.open(path, 'r') do |in_file|
      parser = Parser.new(in_file)
      writer.file_name = File.basename(path).gsub(/\.vm$/, '')

      while parser.has_more_commands?
        next unless parser.advance

        writer.write(parser.command, parser.arg1, parser.arg2)
      end
    end
  end
end
