# frozen_string_literal: true

require 'minitest/autorun'
require './parser'
require './symbol_table'

class ParserTest < MiniTest::Unit::TestCase
  def teardown
    @file&.close
  end

  def test_advance__has_more_commands?
    p = new_parser('Simple.asm')

    assert p.has_more_commands?
    2.times { p.advance }
    assert !p.has_more_commands?
  end

  def test_parse_acommand
    p = new_parser

    command = p.parse_command('@value')

    assert command.instance_of?(Parser::ACommand)
    assert_equal 'value', command.symbol

    command = p.parse_command('@120')

    assert command.instance_of?(Parser::ACommand)
    assert_equal 120, command.address
  end

  def test_parse_lcommand
    p = new_parser

    command = p.parse_command('(LOOP)')

    assert command.instance_of?(Parser::LCommand)
    assert_equal 'LOOP', command.symbol
  end

  def test_parse_ccommand # rubocop:disable Metrics/MethodLength
    p = new_parser

    table = [
      ['D', [nil, 'D', nil]],
      ['A=-1', ['A', '-1', nil]],
      ['0;JMP', [nil, '0', 'JMP']],
      ['AMD=D|A;JEQ', %w[AMD D|A JEQ]]
    ]

    table.each do |input, expected|
      command = p.parse_command(input)

      assert command.instance_of?(Parser::CCommand)
      assert_equal expected, [command.dest, command.comp, command.jump]
    end
  end

  private

  def new_parser(filename = 'Empty.asm')
    @file = File.open("test/files/#{filename}", 'r')
    Parser.new(@file)
  end
end
