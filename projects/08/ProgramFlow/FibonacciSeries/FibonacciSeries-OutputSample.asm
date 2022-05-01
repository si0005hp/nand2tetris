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
//<pop pointer 1
@SP
M=M-1
A=M
D=M
@R3
A=A+1
M=D
//>pop pointer 1
//<push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 0
//<pop that 0
@SP
M=M-1
A=M
D=M
@THAT
A=M
M=D
//>pop that 0
//<push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 1
//<pop that 1
@SP
M=M-1
A=M
D=M
@THAT
A=M
A=A+1
M=D
//>pop that 1
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
//<pop argument 0
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
//>pop argument 0

// label MAIN_LOOP_START
(MAIN_LOOP_START)

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

// if-goto COMPUTE_ELEMENT // if num_of_elements > 0, goto COMPUTE_ELEMENT
@SP
M=M-1
A=M
D=M
@COMPUTE_ELEMENT
D;JNE

// goto END_PROGRAM        // otherwise, goto END_PROGRAM
@END_PROGRAM
0;JMP

// label COMPUTE_ELEMENT
(COMPUTE_ELEMENT)

//<push that 0
@THAT
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push that 0
//<push that 1
@THAT
A=M
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push that 1
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
//<pop that 2
@SP
M=M-1
A=M
D=M
@THAT
A=M
A=A+1
A=A+1
M=D
//>pop that 2
//<push pointer 1
@R3
A=A+1
D=M
@SP
A=M
M=D
@SP
M=M+1
//>push pointer 1
//<push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 1
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
//<pop pointer 1
@SP
M=M-1
A=M
D=M
@R3
A=A+1
M=D
//>pop pointer 1
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
//<pop argument 0
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
//>pop argument 0

// goto MAIN_LOOP_START
@MAIN_LOOP_START
0;JMP

// label END_PROGRAM
(END_PROGRAM)
