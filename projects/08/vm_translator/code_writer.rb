# frozen_string_literal: true

class CodeWriter # rubocop:disable Metrics/ClassLength
  def initialize(output)
    @output = output
    @system_label_id = 0
  end

  def write(line, command, arg1, arg2) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize
    with_comment(line) do
      case command
      when 'push'
        write_codes(push_codes(arg1, arg2))
      when 'pop'
        write_codes(pop_codes(arg1, arg2))
      when 'label'
        write_codes(label_codes(arg1))
      when 'goto'
        write_codes(goto_codes(arg1))
      when 'if-goto'
        write_codes(if_goto_codes(arg1))
      when 'function'
        write_codes(function_codes(arg1, arg2))
      when 'call'
        write_codes(call_codes(arg1, arg2))
      when 'return'
        write_codes(return_codes)
      else
        write_codes(arithmetic_codes(command))
      end
    end
  end

  def file_name=(file_name)
    @file_name = file_name
    write_header_comment(@file_name)
  end

  def write_bootstrap
    write_header_comment('Bootstrap')
    # SP=256
    write_codes(
      %w[
        @256
        D=A
        @SP
        M=D
      ]
    )
    # call Sys.init
    write('call Sys.init 0', 'call', 'Sys.init', '0')
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
    @system_label_id += 1
    label_true = "CMP_T#{@system_label_id}"
    label_false = "CMP_F#{@system_label_id}"

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

  def label_codes(label)
    ["(#{label})"]
  end

  def goto_codes(label)
    %W[
      @#{label}
      0;JMP
    ]
  end

  def if_goto_codes(label)
    [
      pop,
      %W[
        @#{label}
        D;JNE
      ]
    ].flatten
  end

  def function_codes(fn_name, arity)
    # function label
    codes = ["(#{fn_name})"]
    # local initializations
    arity.to_i.times { codes.concat(push_codes('constant', 0)) }

    codes
  end

  def call_codes(fn_name, arity) # rubocop:disable Metrics/MethodLength
    @system_label_id += 1
    return_address_symbol = "#{fn_name}.return.#{@system_label_id}"

    [
      # push return-address
      %W[
        @#{return_address_symbol}
        D=A
      ],
      push,
      # push LCL
      # push ARG
      # push THIS
      # push THAT
      %w[LCL ARG THIS THAT].map do |segment|
        [
          %W[
            @#{segment}
            D=M
          ],
          push
        ].flatten
      end,
      # ARG = SP-n-5 (n: arity)
      %W[
        @SP
        A=M
        #{(arity.to_i + 5).times.map { 'A=A-1' }.join("\n")}
        D=A
        @ARG
        M=D
      ],
      # LCL = SP
      %w[
        @SP
        D=M
        @LCL
        M=D
      ],
      # goto f, (return-address)
      %W[
        @#{fn_name}
        0;JMP
        (#{return_address_symbol})
      ]
    ].flatten
  end

  def return_codes # rubocop:disable Metrics/MethodLength
    [
      # FRAME = LCL
      %w[
        @LCL
        D=M
        @FRAME
        M=D
      ],
      # RET = *(FRAME-5)
      store_frame_segment_codes('RET', 5),
      # *ARG = pop()
      pop,
      %w[
        @ARG
        A=M
        M=D
      ],
      # SP = ARG + 1
      %w[
        @ARG
        D=M+1
        @SP
        M=D
      ],
      # THAT = *(FRAME-1)
      # THIS = *(FRAME-2)
      # ARG = *(FRAME-3)
      # LCL = *(FRAME-4)
      %w[THAT THIS ARG LCL].map.with_index(1) do |segment, i|
        store_frame_segment_codes(segment, i)
      end,
      # goto RET
      %w[
        @RET
        A=M
        0;JMP
      ]
    ].flatten
  end

  def store_frame_segment_codes(dest_symbol, frame_offset)
    %W[
      @FRAME
      A=M
      #{frame_offset.times.map { 'A=A-1' }.join("\n")}
      D=M
      @#{dest_symbol}
      M=D
    ]
  end

  def write_codes(codes)
    codes.each { |code| @output.write("#{code}\n") }
  end

  def with_comment(comment)
    @output.write("//<#{comment}\n")
    yield
    @output.write("//>#{comment}\n")
  end

  def write_header_comment(header)
    @output.write(<<~FILE_NAME_COMMENT)
      // ####################
      // #{header}
      // ####################
    FILE_NAME_COMMENT
  end
end
