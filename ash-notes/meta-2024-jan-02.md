notes on notes

algorithm: sequence of instructions

# LLVM core components

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

# Compilers & OSs

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


- SIMT ISAs: (CUDA is based off of SIMT; SIMT is based off of SIMD)
  - thread sync: `barrier`
  - data movement: `ld` `st`
  - ALU/CLU ops: `add` `sub` `mul` `div` `and` `or` `xor` `not`
  - comparison ops: `setp` `set` set predicate based on comparison & set variable based on predicate
  - contrl flow: `bra` `exit` `call` `ret`
  - special functions: `sin` `cos` `sqrt`
  - shuffle and warp ops: `shfl` shuffle data within a warp
  - floating-point ops: `fadd` `fsub` `fmul` `fdiv` floating-point arithmetic ops
  - load/store of specialized memory: `ldg` `stg` load and store global memory
  - predication and masking: `@p0` `@!p0` predicated execution based on conditions
  - misc: `vote` performs a vote operation within a warp
- CUDA: "a single instruction is executed across multiple threads within a thread block. Each thread follows the same program, and threads within a block can diverge in their execution paths based on conditional statements"

SIMT (cont.):
- select threads can be activated/deactivated, and preserve local data on inactive threads, which accommodates branching (though not efficiently)

"Many vector instructions in Intel's x86_64 have masked variants, in which a vector instruction can be turned on/off for selected vector lanes according to the true/false values in an extra vector operand. This extra operand is called a "mask" because it functions like one: it "hides" certain vector lanes. And the masking trick enables branching to be vectorized on CPUs, too, to a limited extent."

warp: block/bundle of 32 threads with consecutive thread indexes (etymology from weaving, the first parallel-thread technology) (like a vectorized loop chunked into fixed-size vectors and processed by a set of vector lanes; VPUs within CPUs) (avoid branching in a warp because it damages efficiency) (warp is hardware detail?); warp is a small group of threads

coalescing: merge memory access across threads and hide latency; memory is a bottleneck

execute the same instruction in lockstep across multiple datapath lanes with each thread occupying one lane to compute and independent result from its own operands. threading model: "SIMT machine can host numerous in-flight warps", each thread has its own program counter and stacks so threads can have divergent execution paths ; divergence across warps is okay but divergence within warps is bad; think about costs for fetch/decode/issue


ISAs: SIMT, SIMD, MIMD, SPMD, Vector Processor, Array Processor, Dataflow Architectures, and VLIW

"In summary, the main differences lie in how these architectures exploit parallelism, whether through multiple threads, data parallelism, independent program execution, vectorized operations, array processing, dataflow principles, or compiler-driven scheduling. The choice of architecture depends on the specific requirements of the application and the desired balance between flexibility and efficiency."


...



...


# Computer History

bit: binary digit

- switches & relays: can break or complete circuit with positive/negative voltage
- mechanical switches: typically manual device like toggles, push-button, and rotary
- electrical switches: involve solid-state components and use electricity while relays use electromagnets
- relays can use small current to control a larger current. have coil, armature and set of contacts. generates magnetic field that attracts the armature, causing contacts to open or close. (useful for remote or automated control) provide isolations between different parts of a circuit, amplify signals, or control high-power loads with a low-power signal. activate an electromagnet.
- circuits: connections of switches (made of switches, relays, gates, resistors, capacitors, etc.)
- logic gates: digital components that perform logical operations when they process binary inputs (AND, OR, NOT, NAND, NOR, XOR); building blocks of digital circuits
- electronic computers: 1930s/1940s, e.g. ENIAC: 10k electrical switches, thousands of calculations per second such as calculating tables of ballistic trajectories

- processors are a type of circuit that executes instructions
- today: millions or billions of switches on a processor
- memory: a circuit that can store 0s and 1s in each of a series of thousands of addressed locations. can store data and instructions.
- memory can store intemediate/temporary results
- computer is basically memory and processor.
- instructions: LOAD, STORE, MOV, ADD, SUB, MUL, DIV, AND, OR, XOR, NOT, JUMP, BRANCH, CALL, RETURN, CMP, SHIFT, ROTATE, IN, OUT, FADD, FMUL, VECTOR ADD, VECTOR MULTIPLY, HALT, NOP

"New flash storage devices store 0s and 1s in a non-volatile memory, rather than disk by tunneling electrons into special circuits on the memory's chip and removing them with a "flash" of electricity that draws the electrons back out.

1960s & 1970s: High-level languages
1972: C by Dennis Ritchie at Bell Labs

(java) virtual machine (JVM): can run universal bytecode which runs on a machine on a machine so you don't need target-specific machine code (slower, but portable executables)

disk: magnetic
"New flash storage devices store 0s and 1s in a non-volatile memory, rather than disk by tunneling electrons into special circuits on the memory's chip and removing them with a "flash" of electricity that draws the electrons back out."
RAM: a few clock ticks away
SSD: hundreds of clock ticks away
cache memory (on chip): one clock tick away

boot order:
1. BIOS (input/output peripherals)
2. OS

microprocessors = CPUs

1 GHz (1 billion ticks/second)
1 MHz (1 million ticks/second)
1 instruction per clock tick

- transistors: smaller switches
- integrated circuit: transistors integrated onto a single chip
- Moore's Law: capacity of IC doubles every 18mo
- 1971: Intel with the first single-IC processor (4004), a microprocessor because it's small, with 2300 transistors (took 7 years to write the docs)
- 2012: a single IC had several billion transistors containing multiple processors (i.e. cores) (multi-core processor) (each core has its own cache) (can either be identical or different cores: symmetric multi-score SMP or asymmetric multi-core AMP)
- 1985: C++ Bjarne Stroustrup -- OOP
- 1991: Java portable executable for diff processors (James Gosling at Sun Microsystems) (acquired by Oracle in 2010) (4 years to develop it)
- 


