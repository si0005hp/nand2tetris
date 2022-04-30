# frozen_string_literal: true

class CodeWriter
  def write(command_type, arg1, arg2)
    writePushPop(command_type, arg1, arg2)
  end

  def writePushPop(command_type, segment, index)
    case command_type
    when 'C_PUSH'
    when 'C_POP'
    end
  end
end
