@3030   // push constant 3030
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop pointer 0
M=M-1
A=M
D=M
@R3
M=D
@3040   // push constant 3040
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop pointer 1
M=M-1
A=M
D=M
@R3
A=A+1
M=D
@32   // push constant 32
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop this 2
M=M-1
A=M
D=M
@THIS
A=M
A=A+1
A=A+1
M=D
@46   // push constant 46
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop that 6
M=M-1
A=M
D=M
@THAT
A=M
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
M=D
@R3   // push pointer 0
D=M
@SP
A=M
M=D
@SP
M=M+1
@R3   // push pointer 1
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // add
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M+D
@SP
M=M+1
@THIS   // push this 2
A=M
A=A+1
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // sub
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
@THAT   // push that 6
A=M
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // add
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M+D
@SP
M=M+1
