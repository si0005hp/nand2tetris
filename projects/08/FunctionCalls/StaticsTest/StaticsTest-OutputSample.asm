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
//<push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 6
//<push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 8

// call Class1.set 2
@Class1.set.return2   // push return-address
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
A=A-1
D=A
@ARG
M=D
@SP   // LCL = SP
D=M
@LCL
M=D
@Class1.set   // goto f
0;JMP
(Class1.set.return2)

//<pop temp 0
@SP
M=M-1
A=M
D=M
@R5
M=D
//>pop temp 0
//<push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 23
//<push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 15

// call Class2.set 2
@Class2.set.return3   // push return-address
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
A=A-1
D=A
@ARG
M=D
@SP   // LCL = SP
D=M
@LCL
M=D
@Class2.set   // goto f
0;JMP
(Class2.set.return3)

//<pop temp 0
@SP
M=M-1
A=M
D=M
@R5
M=D
//>pop temp 0

// call Class1.get 0
@Class1.get.return4   // push return-address
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
@Class1.get   // goto f
0;JMP
(Class1.get.return4)

// call Class2.get 0
@Class2.get.return5   // push return-address
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
@Class2.get   // goto f
0;JMP
(Class2.get.return5)

(WHILE)  // label WHILE
@WHILE   // goto WHILE
0;JMP

// #############
// Class1.vm
// #############
(Class1.set)
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
//<pop static 0
@SP
M=M-1
A=M
D=M
@Class1.0
M=D
//>pop static 0
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
//<pop static 1
@SP
M=M-1
A=M
D=M
@Class1.1
M=D
//>pop static 1
//<push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 0

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

(Class1.get)
//<push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push static 0
//<push static 1
@Class1.1
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push static 1
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


// #############
// Class2.vm
// #############
(Class2.set)
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
//<pop static 0
@SP
M=M-1
A=M
D=M
@Class2.0
M=D
//>pop static 0
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
//<pop static 1
@SP
M=M-1
A=M
D=M
@Class2.1
M=D
//>pop static 1
//<push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 0

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

(Class2.get)
//<push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push static 0
//<push static 1
@Class2.1
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push static 1
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
