strategy

1. testing main branch updates against branch (done)
2. directory structure (done)
3. study meta-understanding of hardware-to-software process (both open-source and proprietary) (done)
4. step-by-step from beginning (setup & simple example) - find example with MLIR if possible (found some but do this later) (todo)
  - https://github.com/ashlink11/llvm-project/tree/main/mlir/examples 
5. explore an example project directory at a high-level now that i know the four sub-directory structure (some done; todo)
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
6. review LLVM infrastructure (some done; todo)
  - core components
  - tools
  - modules
  - directory layout of a project (can only figure out when i finally run my first project with CMake) (some done; todo)
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
  - make more sense of this compilation process (some done; todo):
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
7. review interpreter vs JIT vs compiler (todo)
8. eventually review: (todo in future)
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
9. review Wired article on chip revolution needed january 2024 (done)
  - universities
  - companies
  - future predictions
10. why are the ModuleMaker project source files like this: (some done; todo -- see #6 which is almost identical)
    - lib
    - include
    - tools
    - test 
    - what is the build order?
      - lib then tools
      - (why do they not all get "built"?)
11. more terminology & source files clarifications: (some done; todo-- see $6 and #10)
    - what is a library, what are the different types of libraries, and what is `/lib`?
    - "libraries can be object files, archives, or dynamic libraries" ?
    - lib holds all library source code
    - "for each library that you build, you will have one directory in lib w the lib's source code"
    - "convenient place so they can all get linked later"
    - whats the difference between libraries, dependencies, tools, and header files? include? 
    - what does it mean that tools contains all the source code for executables? so tools is the main program directory?
12. what are modules? (see meta-map and notes for more detail) (some done; todo)
13. then continue reviewing `ModuleMaker` project code (some done; todo)
14. review all ModuleMaker code (some done; todo)
15. do the CMake tutorials https://cmake.org/cmake/help/latest/guide/tutorial/A%20Basic%20Starting%20Point.html (some done; todo)
16. read the modular documentation on SIMD programming
  - Thurs Feb 8, 2024 - I learned you can write SIMD intructions directly in Mojo
  - start here: https://www.modular.com/blog/outperforming-rust-benchmarks-with-mojo 
  - https://docs.modular.com/mojo/ can use virtual Jupyter notebooks - support coming soon for macOS VSCode
17. how many LLVM installs do i have? where are they? 
    - native
    - github clone
    - homebrew install
    - does CMake generate it? (i.e. from where?)
18. figure out CMake so I can start running LLVM projects (some done; todo)
  - what is my CMake config? which is compatible/current?
    - VSCode extension auto-opens
    - try running it somewhere out of VSCode?
    - Xcode 
  - learn more of CMake from their tutorials (minimum viable)
    - analyze my LLVM project so i can make a custom CMake config
    - find other similar projects online for their configs
19. do i need to be able to see all the header/lib files in the LLVM source install? or are some generated with CMake? 

Most important next steps:
1. (#6, #10, #11, #13, #17, #18, #19) learn which is the proper LLVM installation - intertwined with CMake config
2. (#16) check out Mojo more so I can aim towards: 
   - LLVM --> MLIR --> Mojo (compiler frontend - IR)
   - SIMT --> CUDA API (compiler backend - actual ISA)
