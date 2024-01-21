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
- Support(header files, e.g.: abstract data types (ADT))
- IR
- Transforms(IR-to-IR)
- Analysis (call graphs, natural loop identification)
- Bitcode
- Target(target architectures)
- CodeGen(instructions/scheduling/registers)
- AsmParser
- MC(machine code ASM/object-file emission)
- ExecutionEngine(interpreted/JIT)


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

Wired.com: chip revolution needed (Jan 19, 2024)
 - "model sizes that OpenAI and others have been releasing are growing way faster than chip capacity" (Moore's Law)
  - $100m so far to train OpenAI algos
  - expensive based on energy costs
  - AI gold rush
  - what are fundamentals of a chip? #todo: more research needed. super interesting

Cornell University:
- Peter McMahon
- use light to compute information
- Aspen, Colorado conference: Dutch researchers "mechanical cochlear implant" sound waves to power computations
- chatbots are the first killer app

Extropic: 
- Guillaume Verdon
- ex-Alphabet quantum researchers
- in stealth
- thermodynamic computing for AI
- "neural computing tightly integrated in an analog thermodynamic chip"
- full-stack thermodynamic paradigm
- e/acc
- "technocapital singularity"

Normal Computing: 
- Google Brain and Alphabet's moonshot lab X veterans
- first-principles of computing 
- prototype exists
- stochastic processing unit (SPU)
- "exploits thermodynamic properties of electrical oscillatrs to perform calculations using random fluctuations that occur inside the circuits. that can generate random samples useful for computations or to solve linear algebra calculations" #todo: how?
- efficient
- good for statistical calculations
- stochastic means "random": good for uncertainty / LLM hallucinations when unsure
- we need better software architectures and hardware
- at Alphabet: worked on quantum computing and AI together
- exploit physics
  
Vaire Computing:
- UK
- silicon chips
- "reversible computing": performing calculations without destroying information in the process #todo: what and how?
- devised decades ago but never took off 
- no.1 enemy: heat on the chip so cant easily make components smaller
- "we have one order of magnitude left" quote
- backed by 7percent Ventures
- "we have one order of magnitude left"

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
  - control flow: `bra` `exit` `call` `ret`
  - special functions: `sin` `cos` `sqrt`
  - shuffle and warp ops: `shfl` shuffle data within a warp
  - floating-point ops: `fadd` `fsub` `fmul` `fdiv` floating-point arithmetic ops
  - load/store of specialized memory: `ldg` `stg` load and store global memory
  - predication and masking: `@p0` `@!p0` predicated execution based on conditions
  - misc: `vote` performs a vote operation within a warp

predicate: 
- a predicate is a function that returns a boolean value, often used in conditional statements
- Latin word "praedicare" means "to proclaim" or "to assert." 
- In logic, a predicate is a statement that may be true or false, depending on the values of its variables.

- CUDA: "a single instruction is executed across multiple threads within a thread block. Each thread follows the same program, and threads within a block can diverge in their execution paths based on conditional statements"

SIMT (cont.):
- select threads can be activated/deactivated, and preserve local data on inactive threads, which accommodates branching (though not efficiently)

"Many vector instructions in Intel's x86_64 have masked variants, in which a vector instruction can be turned on/off for selected vector lanes according to the true/false values in an extra vector operand. This extra operand is called a "mask" because it functions like one: it "hides" certain vector lanes. And the masking trick enables branching to be vectorized on CPUs, too, to a limited extent."

warp: block/bundle of 32 threads with consecutive thread indexes (etymology from weaving, the first parallel-thread technology) (like a vectorized loop chunked into fixed-size vectors and processed by a set of vector lanes; VPUs within CPUs) (avoid branching in a warp because it damages efficiency) (warp is hardware detail?); warp is a small group of threads

coalescing: merge memory access across threads and hide latency; memory is a bottleneck

execute the same instruction in lockstep across multiple datapath lanes with each thread occupying one lane to compute and independent result from its own operands. threading model: "SIMT machine can host numerous in-flight warps", each thread has its own program counter and stacks so threads can have divergent execution paths ; divergence across warps is okay but divergence within warps is bad; think about costs for fetch/decode/issue


ISAs: SIMT, SIMD, MIMD, SPMD, Vector Processor, Array Processor, Dataflow Architectures, and VLIW

"In summary, the main differences lie in how these architectures exploit parallelism, whether through multiple threads, data parallelism, independent program execution, vectorized operations, array processing, dataflow principles, or compiler-driven scheduling. The choice of architecture depends on the specific requirements of the application and the desired balance between flexibility and efficiency."


- x86 architectures: a family of ISAs that are based on the Intel 8086 microprocessor, but has evolved over time from 32-bit to 64-bit
- both Intel and AMD use x86 architectures and they can generally execute the same set of basic instructions
- Intel 64-bit x86-64 architecture is equivalent to AMD's AMD64.
- Intel's SSE (Streaming SIMD Extensions) and AMD's 3DNow! are instruction set extensions for parallel processing, etc.
- the equivalent hardware features: Intels' Hyper-Threading Technology and AMD's Simultaneous Multithreading (SMT) 
- older software is generally compatible with newer processors 
- newer software might not be compatible with older processors




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


...


...


...


# JIT Interpreter vs Compiler

- JIT output can run on my machine, but it sends piece by piece of machine code to my OS instead of optimizing machine code specifically for my OS and running quickly all at once 

#todo
remaining questions:
- what is dynamic code generation, dynamic optimization, and dynamic adaptation? is this related to polymorphism and dynamic vs static runtimes?
- whats the exact difference between JIT and interpreted? and JIT vs compiled?
  


...



...



# Linking libraries

### e.g. `libmgpu.a` is a static library file

- it's compiled code for an MGPU
- MGPU is a library that provides primitives for General-Purpose computing on GPUS (GPGPU) 
- Modern GPGPU Primitives: operations such as parallel reductions, scans, sorts, & other parallel algorithms beyond graphics rendering
- enables general-purpose programming to become parallel programming on GPUs
- reminder: `libmgpu.a` is a static file
- static library: collection of object code that is linked with a program at compile time
- polymorphic code: changes binary or bytecode during runtime for security (it can react to new data)
- static code: constant binary or bytecode (good for speed)
- when you compile a program that uses `libmgpu.a`, the necessary code from the library is included in the executable
- vs dynamic libraries: `.so` on Linux and `.dll` on Windows; library code is loaded at runtime
- Linker: "link against it", e.g.: "Always refer to the documentation or accompanying information for the specific library to understand how to correctly use and link against it in your project."






## Intrinsics and Built-ins

- LLVM Intrinsics: target-specific SIMD which are lower-level functions than even C/C++
- intrinsic: directly supported by the underlying hardware or compiler
- vs. extrinsic: information carried by external actors
- Clang built-ins are also known as compiler built-ins or compiler intrinsics, and they are not for specific target-architectures
- Clang built-ins examples: branch prediction hints or population count operations
- clang built-ins are included in headers

- remember, Clang is an LLVM frontend for C/C++/Objective-C (gcc is a frontend and backend)
- different compilers have different built-ins
- clang built-ins support x86, ARM, etc.
- e.g. of an LLVM intrinsic: `_mm_add_ps` for adding two vectors of 4 single-precision floating-point values using Streaming SIMD Extensions (SSE) instructions on x86 architectures
- LLVM intrinsics are included via header files provided by LLVM or the specific target architecture
- the header files declare the intrinsic functions and the developers use these functions in their code
- header files are really just dependencies
- each file has its own object file
- `.h` is a header file

- this is how to include the `<immintrin.h>` header file:

```c
#include <immintrin.h>

void vectorAdd(float *a, float *b, float *result, int size) {
    for (int i = 0; i < size; i += 8) {
        __m256 va = _mm256_loadu_ps(&a[i]);
        __m256 vb = _mm256_loadu_ps(&b[i]);
        __m256 result_vec = _mm256_add_ps(va, vb);
        _mm256_storeu_ps(&result[i], result_vec);
    }
}
```

1. compile source code into an object file `main.o`
2. then link with a static library like `libmgpu.a` (might have to include the other directories if the library has header files and they're in a different directory)
3. `.o` is a native object file



### big-picture of linking `libmgpu.a`

1. LLVM Intrinsic (target-specific)
2. Clang Built-Ins (not target-specific)
3. Built-In Wrappers
4. `libmgpu.a`
5. NVIDIA GPU/AMD GPU

1. CUDA Math API/ROCs Math API
2. Vendor Wrapper
4. `libmgpu.a`
5. NVIDIA GPU/AMD GPU

1. Architecture-Agnostic LIBC
2. LIBC Wrappers
3. `libmgpu.a`
4. NVIDIA GPU/AMD GPU



- LLVM Intrinsics: Target-specific SIMD which are lower-level functions than even C/C++
- Non-target-specific Clang Built-Ins: `__builtin_expect`
- Abstract built-in wrapper interface: can be used to allocate and manage memory and built-ins can be included in these files
- Modern primitives library of extra instructions (can be target-specific or non-target-specific depending on compilation flags)
- Specific hardware



llvm intrinsic: (SIMD ISA)

```c
#include <immintrin.h>

__m128 a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
__m128 b = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
__m128 result = _mm_add_ps(a, b);
```

clang built-in:

```c
if (__builtin_expect(x > 0, 1)) {
    // Likely branch
} else {
    // Unlikely branch
}
```


`custom_malloc` is the wrapper:

```c
#include <builtins.h>
#include <stdlib.h>
#include "libmgpu.h"

// Built-in wrapper for memory allocation with additional functionality
void* custom_malloc(size_t size) {
    // Using Clang built-in for branch prediction
    if (__builtin_expect(size == 0, 0)) {
        // Handle the unexpected case
        return NULL;
    }

    // Using Clang built-ins or other custom logic

    // Call the memory allocation function from libmgpu.a
    void* ptr = libmgpu_malloc(size);

    // Additional functionality or error checking
    if (!ptr) {
        // Handle memory allocation failure
        // Log an error, perform cleanup, etc.
    }

    return ptr;
}

// Example use in a program
int main() {
    // Allocate memory using the custom wrapper
    int* data = (int*)custom_malloc(10 * sizeof(int));

    // Use the allocated memory
    if (data) {
        // Perform operations on 'data'
    }

    // Cleanup or release resources
    libmgpu_free(data);

    return 0;
}
```

