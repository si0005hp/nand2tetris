//<push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//>push constant 0
//<pop local 0
@SP
M=M-1
A=M
D=M
@LCL
A=M
M=D
//>pop local 0

//<label LOOP_START
(LOOP_START)
//>label LOOP_START

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
//<pop local 0
@SP
M=M-1
A=M
D=M
@LCL
A=M
M=D
//>pop local 0
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

//<if-goto LOOP_START  // If counter != 0, goto LOOP_START
@SP    // pop
M=M-1
A=M
D=M

@LOOP_START
D;JNE
//>if-goto LOOP_START  // If counter != 0, goto LOOP_START

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
