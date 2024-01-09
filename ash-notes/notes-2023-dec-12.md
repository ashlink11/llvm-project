LLVM core components:
1. Clang frontend: generates LLVM bitcode
2. libc++ C++ standard library: ISO/IE 14882 standard; after object files/IR, references are resolved by linking with libc++ implementations
3. LLD linker: makes one single .exe/library; static linking: all dependencies included; dynamic linking: dependencies linked at runtime)

https://llvm.org/docs/GettingStarted.html#getting-started-with-the-llvm-system
Directory Layout
llvm/cmake
llvm/examples
llvm/include
llvm/lib
llvm/bindings
llvm/projects
llvm/test
test-suite
llvm/tools
llvm/utils

useful info of internals of LLVM generated from source-code: https://llvm.org/doxygen/index.html 


llvm/cmake

generates system build files

/modules: build config for llvm user-defined options. checks compiler version and linker flags

/platforms: toolchain configuration for Android NDK, iOS systems, and non-Windows hosts to target MSVC (Microsoft Visual C++ Compiler)



llvm/examples

examples for using LLVM for a custom language (lowering, optimization, and code generation)

Kaleidoscope language tutorial: hand-written lexer, parser, AST, as well as codegen support using LLVM both static (ahead of time) and various approaches to Just in time (JIT) compilation

JIT: program is compiler into machine code during runtime, right before it's executed

BuildingAJIT: shows how LLVM's ORC JIT APIs interact with other parts of LLVM. teaches how to recombine them to build a custom JIT that is suited to your use-case




llvm/include

public header files exported from the LLVM library. three main directories:

- llvm/include/llvm : all LLVM-specific header files, and subdirectories for different portions of LLVM: Analysis, CodeGen, Target, Transforms, etc., ...
- llvm/include/llvm/support: generic support libraries provided with LLVM but not necessarily specific to LLVM. For example, some C++ STL utilities and a Command Line option processing library store header files here
- llvm/include/llvm/Config: Header files configured by cmake. They wrap 'standard' UNIX and C header files. Source code can include these header files which automatically take care of the conditional #includes that cmake generates.




llvm/lib

most source files are here. by putting code in libraries, LLVM makes it easy to share code among the tools.

llvm/lib/IR - core LLVM source files that implement core classes like Instruction and BasicBlock

llvm/lib/AsmParser - source code for the LLVM assembly language parser library

llvm/lib/Bitcode - code for reading and writing bitcode

llvm/lib/Analysis - a variety of program analyses, such as Call Graphs, Induction Variable, Natural Loop Identification, etc.

llvm/lib/Transforms - IR-to-IR program transformations, such as Aggressive Dead Code Elimination, Sparse Conditional Constant Propagation, Inlining, Loop Invariant Code Motion, Dead Global Elimination, and many others

llvm/lib/Target - files describing target architectures for code generation. for example, llvm/lib/Target/X86 holds the X86 machine description.

llvm/lib/CodeGen - the major parts of the code generator: Instruction Selector, Instruction Scheduling, and Register Allocation.

llvm/lib/MC/ - the libraries represent and process code at machine code level. handles assembly and object-file emission.

llvm/lib/ExecutionEngine - libraries for directly executing bitcode at runtime in interpreted and JIT-compiled scenarios.

llvm/lib/Support - source code that corresponds to the header files in llvm/include/ADT and llvm/include/Support.




llvm/bindings

bindings for the LLVM compiler infrastructure allow programs written in languages other than C or C++ to take advantage of the LLVM infrastructure. LLVM provides language bindings for OCaml and Python




llvm/projects

uses cmake for invocation. 
docs: [github.com/llvm/docs/CMake.rst](https://github.com/llvm/llvm-project/blob/main/llvm/docs/CMake.rst)
how to make cmake projects that are shipped with LLVM.
also used to make your own projects.




llvm/test

feature and regression tests and other sanity checks on LLVM infrastructure. these are intended to run quickly and cover a lot of territory without being exhaustive.

a regression is a new bug when making an update to the LLVM infrastructure (the compiler and related tools)

types are unit tests (individ components/functions), integration tests (check interactions between different parts of LLVM), functional tests (evaluate the functionality of the compiler, optimizations, code generation, etc.), and performance tests (performance metrics of compiler and generated code)




test-suite

comprehensive correctness, performance, and benchmarking test suite for LLVM. it's in a separate git repo because it contains a large amount of third-party code under a variety of licenses. for details, see the testing guide document.




llvm/tools

executables built out of the libraries above, which form the main part of the user interface. you can always get help for a tool by typing `tool_name - help`. the following is a brief introduction to the most important tools. more detailed information is in the command guide.

bugpoint: used to debug optimization passes or code generation backends by narrowing down the given test case to the minimum number of passes and/or instructions that still cause a problem, whether it is a crash or miscompilation. see howtosubmitabug.html for more information on using bugpoint.

llvm-ar: the archiver produces an archive containing the given LLVM bitcode files, optionally with an index for faster lookup.

llvm-as: the assembler transforms the human readable LLVM assembly to LLVM bitcode

llvm-dis: the disassembler transforms the LLVM bitcode to human readable LLVM assembly

llvm-link: not surprisingly, links multiple LLVM modules into a single program (modules are compiler version and linker flags)

lli: lli is the LLVM interpreter, which can directly execute LLVM bitcode (although very slowly ...). For architectures that support it (currently x86, Sparc, and PowerPC), by default, lli will function as a Just-In-Time compiler (if the functionality was compiled in), and will execute the code much faster than the interpreter.

llc: llc is the LLVM backend compiler, which translates LLVM bitcode to a native code assembly file

opt: opt reads LLVM bitcode, applies a series of LLVM to LLVM transformations (which are specified on the command line), and outputs the resultant bitcode. `opt -help` is a good way to get a list of the program transformations available in LLVM. opt can also run a specific analysis on an input LLVM bitcode file and print the results. primarily useful for debugging analyses, or familiarizing yourself with what an analysis does.




llvm/utils - 

utilities for working with LLVM source code; some are part of the build process because they are code generators for parts of the infrastructure

LLC: the LLVM static compiler
LLI: the LLVM interpreter

`codegen-diff`: finds differences between code that LLC generates and code that LLI generates. this is useful if you are debugging one of them, assuming that the other generates correct output. For the full user manual, run `perldoc codegen-diff`.

`emacs/` - Emacs and XEmacs syntax highlighting for LLVM assembly files and TableGen description files. See the README for information on using them.

`getsrcs.sh`: finds and outputs all non-generated source files, useful if one wishes to do a lot of development across directories and does not want to find each file. one way to use it is to fun, for example: `xemacs 'utils/getsources.sh'` from the top of the LLVM source tree.

`llvmgrep` - performs an `egrep -H -n` on each source file in LLVM and passes it to a regular expression provided on llvmgrep's command line. this is an efficient way of searching the source base for a particular regular expression.

`TableGen/` - contains the tool used to generate register descriptions, instruction set descriptions, and even assemblers from common TableGen description files. (TableGen is a domain-specific language that is part of the compiler backend for target-specific details.)

`vim/` - vim syntax-highlighting for the LLVM assembly files and TableGen description files. See the README for how to use them.







LLVM tools include:

Clang: A C, C++, and Objective-C compiler front end. Clang is known for its fast compilation, expressive diagnostics, and adherence to standards. It's often used as an alternative to GCC.

LLVM-AS / LLVM-Dis: Tools for assembling and disassembling LLVM assembly language. llvm-as assembles LLVM assembly into LLVM bitcode, while llvm-dis disassembles LLVM bitcode into human-readable LLVM assembly.

LLVM-Link / LLVM-Archive: llvm-link links LLVM bitcode files together into a single output file. llvm-ar is an archiver that creates and maintains archives of LLVM bitcode files.

LLVM-Opt: This tool provides various optimization options to manipulate LLVM bitcode, allowing developers to run specific optimization passes or transformations on the code.

LLVM-Dump: Used to print the contents of LLVM bitcode files in human-readable form. It's helpful for examining the structure and contents of LLVM bitcode.

LLVM-NM / LLVM-Symbolizer: llvm-nm lists symbols from object files. llvm-symbolizer translates addresses into source code locations for better error reporting and debugging.

LLVM-MC: A machine code generation utility that assembles and disassembles machine code. It's a low-level tool that directly deals with machine instructions and object file formats.

LLVM-ObjDump: Similar to llvm-dis, but specific for object files. It displays information about object files, including their headers, sections, and assembly code.

LLVM-Profdata / LLVM-Cov: These tools deal with code coverage. llvm-profdata manages profile data files, while llvm-cov displays coverage information based on profile data.

LLVM-Size: Displays the size of sections in an LLVM object file or an archive.

