# frozen_string_literal: true

require 'minitest/autorun'
require './code'

class CodeTest < MiniTest::Unit::TestCase
  def test_c_comp
    assert_equal '1110001100000000', Code.dump_c_code('D')
  end

  def test_c_full
    assert_equal '1110000010001111', Code.dump_c_code('D+A', 'M', 'JMP')
  end

  def test_a
    assert_equal '0000000000001010', Code.dump_a_code(10)
  end
end
