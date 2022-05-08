// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/07/MemoryAccess/StaticTest/StaticTest-OutputSample.tst

load StaticTest-OutputSample.asm,
output-file StaticTest-OutputSample.out,
compare-to StaticTest.cmp,
output-list RAM[256]%D1.6.1;

set RAM[0] 256,    // initializes the stack pointer

repeat 200 {       // enough cycles to complete the execution
  ticktock;
}

output;            // the stack base
