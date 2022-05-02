// function SimpleFunction.test 2
(SimpleFunction.test)
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

//<push local 0
@LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push local 0
//<push local 1
@LCL
A=M
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push local 1
//<add
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M+D
@SP
M=M+1
//>add
//<not
@SP
M=M-1
A=M
M=!M
@SP
M=M+1
//>not
//<push argument 0
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push argument 0
//<add
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M+D
@SP
M=M+1
//>add
//<push argument 1
@ARG
A=M
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push argument 1
//<sub
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
//>sub

// return
@LCL   // FRAME = LCL
D=M
@FRAME
M=D
@FRAME // RET = *(FRAME-5)
A=M
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
D=M
@RET
M=D
@SP   // *ARG = pop()
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG  // SP = ARG + 1
D=M+1
@SP
M=D
@FRAME // THAT = *(FRAME-1)
A=M
A=A-1
D=M
@THAT
M=D
@FRAME // THIS = *(FRAME-2)
A=M
A=A-1
A=A-1
D=M
@THIS
M=D
@FRAME // ARG = *(FRAME-3)
A=M
A=A-1
A=A-1
A=A-1
D=M
@ARG
M=D
@FRAME // LCL = *(FRAME-4)
A=M
A=A-1
A=A-1
A=A-1
A=A-1
D=M
@LCL
M=D
@RET  // goto RET
A=M
0;JMP
