strategy

1. testing main branch updates against branch
2. directory structure
3. meta-understanding of hardware-to-software process (both open-source and proprietary)
4. step-by-step from beginning (setup & simple example) - find example with MLIR if possible (found some but do this later)
  - https://github.com/ashlink11/llvm-project/tree/main/mlir/examples 
5. explore an example project directory at a high-level now that i know the four sub-directory structure
  - figure out if all projects use CMake https://github.com/ashlink11/llvm-project/blob/main/llvm/projects/CMakeLists.txt 
  - which LLVM example project is the simplest? (sidenote: they all have `CMakeLists.txt` files)
    - Bye has 70 lines 
    - BrainF has 470 lines, a header file, and a driver
    - ExceptionDemo has 2000 lines
    - Fibonacci has 150 lines
    - HowToUseJIT has 150 lines
    - HowToUseLLJIT has 100 lines
    - IRTransforms(SimplifyCFG) has 415 lines (control flow graphs)
    - Kaleidoscope has 9 chapter folders, BuildingAJIT folder, MCJIT folder and include folder
    - ModuleMaker has 70 lines and a README with "an extremely simple example of using some simple pieces of the LLVM API ... the .exe simply emits an LLVM bitcode file to stdout. it is designed to show some basic usage of LLVM APIs and how to link to LLVM libraries"
    - ORCV2Examples has 12 different LLJIT folders, 8 different OrcV2CBindings files and an ExampleModules header file
    - ParallelJIT has 330 lines
    - SpeculativeJIT has 200 lines
  - MLIR example projects: (they all have READMEs)
    - minimal-opt
    - standalone
    - toy
    - transform
6. review LLVM infrastructure
  - core components
  - tools
  - modules
  - directory layout
    - which dir has source code? `.c` and `.cpp`
    - which has bitcode? `.bc`
    - where are the header files? `.h`
    - which has IR `.ll`
    - which has object files `.o`
    - which has libc++
    - where is clang
    - where is LLD linker
    - where is mc 
      - executable has no file extension or `.native` 
      - call with `./executable-name` or `./executable-name.native`
    - where are the asm files `.s` (are these always part of the linking phase?)
  - make sense of this:
    `/lib` (LLVM source files for its actual internal code) 
        >
        Support(header files, e.g.: abstract data types (ADT))
        >
        IR
        >
        Transforms(IR-to-IR)
        >
        Analysis (call graphs, natural loop identification)
        >
        Bitcode
        >
        Target(target architectures)
        >
        CodeGen(instructions/scheduling/registers)
        >
        AsmParser
        >
        MC(machine code ASM/object-file emission)
        >
        ExecutionEngine(interpreted/JIT)
7. review interpreter vs JIT vs compiler
8. eventually review:
   - entire software to hardware stack & process
   - LLVM GPU lecture: entire process of linking/connecting GPU Math libraries 
     - Math APIs
       - NVIDIA CUDA Math
       - AMD HIP Math
     - Using:
       - Vendor wrappers
       - LLVM intrinsics --> Clang built-ins
       - LIBC wrappers (for architecture-agnostic LIBC)
     - which all use `libmgpu.a` lib modern primitives (what is `.a` file type?)
       - whats the difference between `.s` and `.a`?
     - then can go to NVIDIA and AMD GPUs 
9. review Wired article on chip revolution needed january 2024
  - universities
  - companies
  - future predictions
10. why are the ModuleMaker project source files like this:
    - lib
    - include
    - tools
    - test 
    - what is the build order?
      - lib then tools
      - (why do they not all get "built"?)
11. more terminology & source files clarifications:
    - what is a library, what are the different types of libraries, and what is `/lib`?
    - "libraries can be object files, archives, or dynamic libraries" ?
    - lib holds all library source code
    - "for each library that you build, you will have one directory in lib w the lib's source code"
    - "convenient place so they can all get linked later"
    - whats the difference between libraries, dependencies, tools, and header files? include? 
    - what does it mean that tools contains all the source code for executables? so tools is the main program directory?
12. what are modules? (see meta-map and notes for more detail) 
13. then continue reviewing `ModuleMaker` project code
14. review all ModuleMaker code
15. do the CMake tutorial https://cmake.org/cmake/help/latest/guide/tutorial/A%20Basic%20Starting%20Point.html

Thurs Feb 8, 2024 - I learned you can write SIMD intructions directly in Mojo

Next steps:
- read the modular documentation on SIMD programming, 
  - start here: https://www.modular.com/blog/outperforming-rust-benchmarks-with-mojo 
  - https://docs.modular.com/mojo/
- figure out CMake so I can start running LLVM projects
  - how many LLVM installs do i have? where are they?
    - native
    - github clone
    - homebrew install
  - what is my CMake config?
    - VSCode extension auto-opens
    - try running it somewhere out of VSCode?
  - learn more of CMake from their tutorials
  - analyze my LLVM project so i can make a custom CMake config