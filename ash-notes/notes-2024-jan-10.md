# getting started with llvm

## terminology & notation

`SRC_ROOT`

This is the top level directory of the LLVM source tree.

`OBJ_ROOT`

This is the top level directory of the LLVM object tree (i.e. the tree where object files and compiled programs will be placed. It can be the same as SRC_ROOT).

## unpacking the llvm archives

If you have the LLVM distribution, you will need to unpack it before you can begin to compile it. LLVM is distributed as a number of different subprojects. Each one has its own download which is a TAR archive that is compressed with the gzip program.

The files are as follows, with x.y marking the version number:

`llvm-x.y.tar.gz`

Source release for the LLVM libraries and tools.

`cfe-x.y.tar.gz`

Source release for the Clang frontend.

# example with clang

- create `hello.c` source file:

```c
#include <stdio.h>

int main() {
  printf("hello world\n");
  return 0;
}
```

- compile into native .exe: `% clang hello.c -o hello`
- `.s` native assembly file
- `.o` native object file 
- final executable is simply named `hello`
- compile into LLVM bitcode file: 
  - `% clang -03 -emit-llvm hello.c -c -o hello.bc`
  - `-S` emits an LLVM `.ll` file (LLVM IR assembly)
  - `-c` emits an LLVM `.bc` file (LLVM bitcode file that represents LLVM IR)
  - This allows you to use the standard LLVM tools on the bitcode file
- run the program in both forms:
  - `% ./hello` 
  - `% lli hello.bc` invokes the LLVM JIT (`lli` - i for interpreter) 
- then `% llvm-dis < hello.bc | less` uses the llvm-dis utility to take a look at the bitcode
  - `llvm-dis` disassembles LLVM bitcode
  - `hello.bc` is the input (`<`) for the `llvm-dis` command
  - pipe: redirects output of this command to another command
  - `less`: a pager that allows you to view text one screen at a time when navigating thru a lot of text
- compile the program to native assembly using the LLC code generator: `% llc hello.bc -o hello.s`
  - `llc` is the LLVM static compiler command-line tool 
    - can specify the target architecture with flags so you can optimize for specific hardware
    - can also control the optimization level
  - input is `hello.bc`
  - `-o` indicates the output file
  - `hello.s` is the assembly code file
- assemble the native assembly language file into a program:
  - `% /opt/SUNWspro/bin/cc -xarch=v9 hello.s -o hello.native` (on Solaris)
  - `% gcc hello.s -o hello.native` (on others)
  - can also use clang instead of gcc, which compiles to assembly and to native and then can execute native
- execute the native code program:
  - `% ./hello.native`




outstanding questions:
- whats the difference between JIT and interpreted? and JIT vs compiled?