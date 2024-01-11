notes on notes

LLVM core components

high-level lang 
--> bitcode 
--> check standard 
--> link dependencies one library/.exe
1. frontend clang generates bitcode (object files/IR)
2. libc++ C++ standard lib ISO/IE 14882 standard resolves references
3. LLD linker (LLVM linker) - static linking: all dependencies included; dynamic linking: dependencies linked at runtime


source files

cmake (compiler version, linker flags, toolchain config for target systems)

examples (walk through the actual process in diff ways)

include (public header files -- which are like main() entry files -- for LLVM code, support libraries, and cmake config)

lib (LLVM source files for its actual internal code) 
- IR
- AsmParser
- Bitcode
- Analysis (call graphs, natural loop identification)
- Transforms(IR-to-IR)
- Target(target architectures)
- CodeGen(instructions/scheduling/registers)
- MC(machine code ASM/object-file emission)
- ExecutionEngine(interpreted/JIT)
- Support(header files, e.g.: abstract data types (ADT))


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
> 

(but where is the code for resolving references/linking and does that happen around the bitcode stage? is cmake used during Target?)

...


...


...


...

Intermediate Representation (IR): platform-independent program semantics (abstract language to target-specific). LLVM backends can optimize and codegen for different architectures. MLIR supports LLVM, SPIR-V, NVVM, and RISC-V.

platform-dependent (software to hardware interface):
- Assembly (ASM): mnemonics, symbolic representation of instructions for registers and memory locations (human-readable)
- machine code: binary executables with operators and operands which is hardware instruction set architecture (ISA): (CISC/RISC either complex or reduced) e.g.: x86, ARM, MIPS, RISC-V, SPARC, CUDA, etc., Instruction Set: arithmetic, logic and data movement.

hardware: pipeline, components, register-transfer layer represents hardware circuits and gates

NVIDIA: 

- NVCC is a compiler for CUDA code. (NVIDIA CUDA Compiler Driver) and NVVM IR is within NVCC.
- CUDA hardware: propritary ISA with CUDA Toolkti C++ API programming guide. CUDA runtime. CUDA compiles CUDA kernel and host code. based off SIMD, MIMD, and SINT parallel architecture design

Google:
- TensorFlow (written in C++ by Google Brain) uses Python
- TPU Compiler: written in C++; translates TensorFlow computation graphs into TPU machine code (part of the TensorFlow architecture
- XLA (Accelerated Linear Algebra): domain-specific compiler for linear algebra operations used to optimize and compile subgraphs of TensorFlow computation graphs for execution on accelerators. XLA introduces a set of operators and optimizations
- TPU hardware: TPU means TensorFlow Processing Units; proprietary TPU ISA 