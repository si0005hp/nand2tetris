# frozen_string_literal: true

class Code
  C_NIMONIC_BIT_MAP = {
    'COMP' => {
      '0' => '0101010',
      '1' => '0111111',
      '-1' => '0111010',
      'D' => '0001100',
      'A' => '0110000',
      '!D' => '0001101',
      '!A' => '0110001',
      '-D' => '0001111',
      '-A' => '0110011',
      'D+1' => '0011111',
      'A+1' => '0110111',
      'D-1' => '0001110',
      'A-1' => '0110010',
      'D+A' => '0000010',
      'D-A' => '0010011',
      'A-D' => '0000111',
      'D&A' => '0000000',
      'D|A' => '0010101',

      'M' => '1110000',
      '!M' => '1110001',
      '-M' => '1110011',
      'M+1' => '1110111',
      'M-1' => '1110010',
      'D+M' => '1000010',
      'D-M' => '1010011',
      'M-D' => '1000111',
      'D&M' => '1000000',
      'D|M' => '1010101'
    },

    'DEST' => {
      'null' => '000',
      'M' => '001',
      'D' => '010',
      'MD' => '011',
      'A' => '100',
      'AM' => '101',
      'AD' => '110',
      'AMD' => '111'
    },

    'JUMP' => {
      'null' => '000',
      'JGT' => '001',
      'JEQ' => '010',
      'JGE' => '011',
      'JLT' => '100',
      'JNE' => '101',
      'JLE' => '110',
      'JMP' => '111'
    }
  }.freeze

  def self.dump(command)
    case command
    when Parser::ACommand
      dump_a_code(command.address)
    when Parser::CCommand
      dump_c_code(command.comp, command.dest, command.jump)
    else
      raise "[Code error]: Unexpexted command type '#{command.class}'"
    end
  end

  def self.dump_a_code(address)
    format('%016b', address)
  end

  def self.dump_c_code(comp, dest = nil, jump = nil)
    [
      '111', # C code prefix
      nimonic_to_bit('COMP', comp),
      nimonic_to_bit('DEST', dest || 'null'),
      nimonic_to_bit('JUMP', jump || 'null')
    ].join
  end

  def self.nimonic_to_bit(type, nimonic)
    bitmap = C_NIMONIC_BIT_MAP[type]
    return bitmap[nimonic] if bitmap[nimonic]

    raise "[Code error]: Invalid #{type.to_lowercase} nimonic '#{nimonic}'. " \
          "Valid ones are #{bitmap.keys}"
  end
end
