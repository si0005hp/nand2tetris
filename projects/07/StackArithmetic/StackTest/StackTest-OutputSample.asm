  @17   // push constant 17
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @17   // push constant 17
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // eq
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T1
  D;JEQ
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F1
  0;JMP
(EQ_T1) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F1)

  @17   // push constant 17
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @16   // push constant 16
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // eq
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T2
  D;JEQ
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F2
  0;JMP
(EQ_T2) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F2)

  @16   // push constant 16
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @17   // push constant 17
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // eq
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T3
  D;JEQ
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F3
  0;JMP
(EQ_T3) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F3)

  @892   // push constant 892
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @891   // push constant 891
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // lt
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T4
  D;JLT
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F4
  0;JMP
(EQ_T4) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F4)

  @891   // push constant 891
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @892   // push constant 892
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // lt
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T5
  D;JLT
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F5
  0;JMP
(EQ_T5) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F5)

  @891   // push constant 891
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @891   // push constant 891
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // lt
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T6
  D;JLT
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F6
  0;JMP
(EQ_T6) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F6)

  @32767   // push constant 32767
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @32766   // push constant 32766
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // gt
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T7
  D;JGT
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F7
  0;JMP
(EQ_T7) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F7)

  @32766   // push constant 32766
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @32767   // push constant 32767
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // gt
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T8
  D;JGT
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F8
  0;JMP
(EQ_T8) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F8)

  @32766   // push constant 32766
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @32766   // push constant 32766
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @SP   // gt
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  D=M-D
  @EQ_T9
  D;JGT
  @SP // false
  A=M
  M=0
  @SP
  M=M+1
  @EQ_F9
  0;JMP
(EQ_T9) // true
  @SP
  A=M
  M=-1
  @SP
  M=M+1
(EQ_F9)

  @57   // push constant 57
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @31   // push constant 31
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1
  @53   // push constant 53
  D=A
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
  @112   // push constant 112
  D=A
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

  @SP   // neg
  M=M-1
  A=M
  M=-M
  @SP
  M=M+1

  @SP   // and
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  M=M&D
  @SP
  M=M+1

  @82   // push constant 82
  D=A
  @SP
  A=M
  M=D
  @SP
  M=M+1

  @SP   // or
  M=M-1
  A=M
  D=M
  @SP
  M=M-1
  A=M
  M=M|D
  @SP
  M=M+1

  @SP   // not
  M=M-1
  A=M
  M=!M
  @SP
  M=M+1

(END)
  @END
  0;JMP
