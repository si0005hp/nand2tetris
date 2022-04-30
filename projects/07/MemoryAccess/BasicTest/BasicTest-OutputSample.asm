@10   // push constant 10
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop local 0
M=M-1
A=M
D=M
@LCL
A=M
M=D
@21   // push constant 21
D=A
@SP
A=M
M=D
@SP
M=M+1
@22   // push constant 22
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop argument 2
M=M-1
A=M
D=M
@ARG
A=M
A=A+1
A=A+1
M=D
@SP   // pop argument 1
M=M-1
A=M
D=M
@ARG
A=M
A=A+1
M=D
@36   // push constant 36
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop this 6
M=M-1
A=M
D=M
@THIS
A=M
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
M=D
@42   // push constant 42
D=A
@SP
A=M
M=D
@SP
M=M+1
@45   // push constant 45
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop that 5
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
M=D
@SP   // pop that 2
M=M-1
A=M
D=M
@THAT
A=M
A=A+1
A=A+1
M=D
@510   // push constant 510
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP   // pop temp 6
M=M-1
A=M
D=M
@R5
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
A=A+1
M=D
@LCL   // push local 0
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT   // push that 5
A=M
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
@ARG   // push argument 1
A=M
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
@THIS   // push this 6
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
@THIS   // push this 6
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
@R5   // push temp 6
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
