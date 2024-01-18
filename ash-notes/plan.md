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
    - 
