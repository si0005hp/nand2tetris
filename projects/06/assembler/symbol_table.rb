# frozen_string_literal: true

class SymbolTable
  RESERVED_SYMBOLS = {
    'SP' => 0,
    'LCL' => 1,
    'ARG' => 2,
    'THIS' => 3,
    'THAT' => 4,

    'R0' => 0,
    'R1' => 1,
    'R2' => 2,
    'R3' => 3,
    'R4' => 4,
    'R5' => 5,
    'R6' => 6,
    'R7' => 7,
    'R8' => 8,
    'R9' => 9,
    'R10' => 10,
    'R11' => 11,
    'R12' => 12,
    'R13' => 13,
    'R14' => 14,
    'R15' => 15,

    'SCREEN' => 163_84,
    'KBD' => 245_76
  }.freeze

  def initialize
    @table = { **RESERVED_SYMBOLS }
    @next_variable_address = 16
  end

  def write_label(label, address)
    @table[label] = address
  end

  def add_variable(variable)
    return if @table[variable]

    @table[variable] = @next_variable_address
    @next_variable_address += 1
  end

  def fetch(key)
    @table.fetch(key)
  end
end
