// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// int i = 0;
// while (i < 512) {
//   // put color
//   i++;
// }

(LOOP_MAIN)
  @i
  M=0

(LOOP_SCREEN)
  @i
  D=M
  @8192
  D=D-A // D=i-8192
  @END
  D;JGE

  @SCREEN
  D=A
  @i
  D=D+M
  @screen_bit
  M=D

  @KBD
  D=M
  @KBD_IF_BLACK
  D;JNE
(KBD_IF_WHITE)
  D=0
  @KBD_IF_END
  0;JMP
(KBD_IF_BLACK)
  D=-1 // 1111111111111111
(KBD_IF_END)
  
  @screen_bit
  A=M
  M=D

  @i
  M=M+1 // i=i+1

  @LOOP_SCREEN
  0;JMP

(END)
  @LOOP_MAIN
  0;JMP
