// #############
// Bootstrap code
// #############
// -- SP=256
@256
D=A
@SP
M=D
// -- call Sys.init
@Sys.init.return1   // push return-address
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL   // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG   // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS   // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT   // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // ARG = SP-n-5 (n: argCount)
A=M
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
D=A
@ARG
M=D
@SP   // LCL = SP
D=M
@LCL
M=D
@Sys.init   // goto f
0;JMP
(Sys.init.return1)

// #############
// Sys.vm
// #############
(Sys.init)
//<push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 4
// call Main.fibonacci 1
@Main.fibonacci.return2   // push return-address
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL   // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG   // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS   // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT   // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // ARG = SP-n-5 (n: argCount)
A=M
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
D=A
@ARG
M=D
@SP   // LCL = SP
D=M
@LCL
M=D
@Main.fibonacci   // goto f
0;JMP
(Main.fibonacci.return2)

(WHILE)
@WHILE
0;JMP

// #############
// Main.vm
// #############
(Main.fibonacci)
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
//<push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 2
//<lt
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@CMP_T1
D;JLT
@SP
A=M
M=0
@SP
M=M+1
@CMP_F1
0;JMP
(CMP_T1)
@SP
A=M
M=-1
@SP
M=M+1
(CMP_F1)
//>lt

// if-goto IF_TRUE
@SP
M=M-1
A=M
D=M
@IF_TRUE
D;JNE
// goto IF_FALSE
@IF_FALSE
0;JMP
// label IF_TRUE          // if n<2, return n
(IF_TRUE)

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

// label IF_FALSE         // if n>=2, returns fib(n-2)+fib(n-1)
(IF_FALSE)

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
//<push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 2
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

//// call Main.fibonacci 1  // computes fib(n-2)
@Main.fibonacci.return3   // push return-address
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL   // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG   // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS   // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT   // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // ARG = SP-n-5 (n: argCount)
A=M
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
D=A
@ARG
M=D
@SP   // LCL = SP
D=M
@LCL
M=D
@Main.fibonacci   // goto f
0;JMP
(Main.fibonacci.return3)

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
//<push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 1
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

//// call Main.fibonacci 1  // computes fib(n-1)
@Main.fibonacci.return4   // push return-address
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL   // push LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG   // push ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS   // push THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT   // push THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP   // ARG = SP-n-5 (n: argCount)
A=M
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
D=A
@ARG
M=D
@SP   // LCL = SP
D=M
@LCL
M=D
@Main.fibonacci   // goto f
0;JMP
(Main.fibonacci.return4)

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
