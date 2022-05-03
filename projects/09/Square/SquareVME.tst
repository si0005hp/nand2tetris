load,  // Load all the VM files from the current directory
output-file Square.out,
// compare-to SimpleAdd.cmp,
output-list RAM[0]%D2.6.2 RAM[256]%D2.6.2;

set RAM[0] 256,  // initializes the stack pointer

set sp 261,

repeat 110 {
  vmstep;
}

output;          // the stack pointer and the stack base
