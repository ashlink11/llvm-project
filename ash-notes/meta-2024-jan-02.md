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
Analysis (call graphs, natural loop identification)
>
IR
>
Transforms(IR-to-IR)
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

(but where is the code for resolving references/linking and does that happen around the bitcode stage? is target actually after bitcode? is cmake used during Target?)

