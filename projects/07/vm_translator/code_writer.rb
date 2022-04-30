# frozen_string_literal: true

class CodeWriter # rubocop:disable Metrics/ClassLength
  attr_accessor :file_name

  def initialize(output)
    @output = output
    @compare_label_index = 0
  end

  def write(command, arg1, arg2)
    case command
    when 'push'
      write_codes(push_codes(arg1, arg2), "#{command} #{arg1} #{arg2}")
    when 'pop'
      write_codes(pop_codes(arg1, arg2), "#{command} #{arg1} #{arg2}")
    else
      write_codes(arithmetic_codes(command), command)
    end
  end

  private

  def arithmetic_codes(command) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    case command
    when 'add'
      binary_op('M=M+D')
    when 'sub'
      binary_op('M=M-D')
    when 'and'
      binary_op('M=M&D')
    when 'or'
      binary_op('M=M|D')
    when 'not'
      unary_op('M=!M')
    when 'neg'
      unary_op('M=-M')
    when 'eq'
      compare_op('JEQ')
    when 'gt'
      compare_op('JGT')
    when 'lt'
      compare_op('JLT')
    end
  end

  def push_codes(segment, index)
    [
      segment == 'constant' ? constant_codes(index) : segment_codes(segment, index, 'D=M'),
      push
    ].flatten
  end

  def pop_codes(segment, index)
    [
      pop,
      segment_codes(segment, index, 'M=D')
    ].flatten
  end

  def push
    %w[
      @SP
      A=M
      M=D
      @SP
      M=M+1
    ]
  end

  def pop
    %w[
      @SP
      M=M-1
      A=M
      D=M
    ]
  end

  def constant_codes(value)
    %W[
      @#{value}
      D=A
    ]
  end

  # segment name => [symbol, is_pointer?]
  RAM_SEGMENT_MAP = {
    'local' => ['@LCL', true],
    'argument' => ['@ARG', true],
    'this' => ['@THIS', true],
    'that' => ['@THAT', true],
    'pointer' => ['@R3', false],
    'temp' => ['@R5', false]
  }.freeze

  def segment_codes(segment, index, op_code)
    return segment_static(index, op_code) if segment == 'static'

    symbol, is_pointer = RAM_SEGMENT_MAP.fetch(segment)

    codes = [symbol]
    codes << 'A=M' if is_pointer
    index.to_i.times { codes << 'A=A+1' } # offset
    codes << op_code
  end

  def segment_static(index, op_code)
    %W[
      @#{@file_name}.#{index}
      #{op_code}
    ]
  end

  ### arithmetic ops ###

  def binary_op(op_code)
    [
      pop,
      op_stack_top(op_code)
    ].flatten
  end

  def unary_op(op_code)
    op_stack_top(op_code)
  end

  def op_stack_top(op_code)
    %W[
      @SP
      M=M-1
      A=M
      #{op_code}
      @SP
      M=M+1
    ]
  end

  def compare_op(jmp_code) # rubocop:disable Metrics/MethodLength
    @compare_label_index += 1
    label_true = "CMP_T#{@compare_label_index}"
    label_false = "CMP_F#{@compare_label_index}"

    [
      pop,
      %W[
        @SP
        M=M-1
        A=M
        D=M-D
        @#{label_true}
        D;#{jmp_code}
        @SP
        A=M
        M=0
        @SP
        M=M+1
        @#{label_false}
        0;JMP
        (#{label_true})
        @SP
        A=M
        M=-1
        @SP
        M=M+1
        (#{label_false})
      ]
    ].flatten
  end

  def write_codes(codes, comment = nil)
    @output.write("//<#{comment}\n") if comment
    codes.each { |code| @output.write("#{code}\n") }
    @output.write("//>#{comment}\n") if comment
  end
end
