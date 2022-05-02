// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/08/FunctionCalls/FibonacciElement/FibonacciElement-OutputSample.tst

// FibonacciElement.asm results from translating both Main.vm and Sys.vm into
// a single assembly program, stored in the file FibonacciElement-OutputSample.asm.

load FibonacciElement-OutputSample.asm,
output-file FibonacciElement-OutputSample.out,
// compare-to FibonacciElement.cmp,
// output-list RAM[0]%D1.6.1 RAM[261]%D1.6.1;
output-list RAM[0]%D1.6.1 RAM[256]%D1.6.1 RAM[257]%D1.6.1 RAM[258]%D1.6.1 RAM[259]%D1.6.1 RAM[260]%D1.6.1 RAM[261]%D1.6.1;

repeat 6000 {
  ticktock;
}

output;
output-list RAM[262]%D1.6.1 RAM[263]%D1.6.1 RAM[264]%D1.6.1 RAM[265]%D1.6.1 RAM[266]%D1.6.1 RAM[267]%D1.6.1 RAM[268]%D1.6.1;
output;

output-list RAM[350]%D1.6.1 RAM[351]%D1.6.1 RAM[352]%D1.6.1 RAM[353]%D1.6.1 RAM[354]%D1.6.1 RAM[355]%D1.6.1 RAM[356]%D1.6.1;
output;
