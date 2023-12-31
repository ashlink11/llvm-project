; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

define i1000 @square(i1000 %A) nounwind {
; CHECK-LABEL: square:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    pushq %r13
; CHECK-NEXT:    pushq %r12
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    movq %rsi, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq %rdi, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rbx
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %r15
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %r14
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %r12
; CHECK-NEXT:    bswapq %r12
; CHECK-NEXT:    movq %r12, %r10
; CHECK-NEXT:    shrq $4, %r10
; CHECK-NEXT:    movabsq $1085102592571150095, %rsi # imm = 0xF0F0F0F0F0F0F0F
; CHECK-NEXT:    andq %rsi, %r10
; CHECK-NEXT:    andq %rsi, %r12
; CHECK-NEXT:    shlq $4, %r12
; CHECK-NEXT:    orq %r10, %r12
; CHECK-NEXT:    movabsq $3689348814741910323, %r10 # imm = 0x3333333333333333
; CHECK-NEXT:    movq %r12, %r13
; CHECK-NEXT:    andq %r10, %r13
; CHECK-NEXT:    shrq $2, %r12
; CHECK-NEXT:    andq %r10, %r12
; CHECK-NEXT:    leaq (%r12,%r13,4), %r12
; CHECK-NEXT:    movabsq $6148914691230924800, %r13 # imm = 0x5555555555000000
; CHECK-NEXT:    movq %r12, %rbp
; CHECK-NEXT:    andq %r13, %rbp
; CHECK-NEXT:    shrq %r12
; CHECK-NEXT:    andq %r13, %r12
; CHECK-NEXT:    leaq (%r12,%rbp,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    bswapq %r14
; CHECK-NEXT:    movq %r14, %r12
; CHECK-NEXT:    shrq $4, %r12
; CHECK-NEXT:    andq %rsi, %r12
; CHECK-NEXT:    andq %rsi, %r14
; CHECK-NEXT:    shlq $4, %r14
; CHECK-NEXT:    orq %r12, %r14
; CHECK-NEXT:    movq %r14, %r12
; CHECK-NEXT:    andq %r10, %r12
; CHECK-NEXT:    shrq $2, %r14
; CHECK-NEXT:    andq %r10, %r14
; CHECK-NEXT:    leaq (%r14,%r12,4), %r12
; CHECK-NEXT:    movabsq $6148914691236517205, %r14 # imm = 0x5555555555555555
; CHECK-NEXT:    movq %r12, %r13
; CHECK-NEXT:    andq %r14, %r13
; CHECK-NEXT:    shrq %r12
; CHECK-NEXT:    andq %r14, %r12
; CHECK-NEXT:    leaq (%r12,%r13,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    bswapq %r15
; CHECK-NEXT:    movq %r15, %r12
; CHECK-NEXT:    shrq $4, %r12
; CHECK-NEXT:    andq %rsi, %r12
; CHECK-NEXT:    andq %rsi, %r15
; CHECK-NEXT:    shlq $4, %r15
; CHECK-NEXT:    orq %r12, %r15
; CHECK-NEXT:    movq %r15, %r12
; CHECK-NEXT:    andq %r10, %r12
; CHECK-NEXT:    shrq $2, %r15
; CHECK-NEXT:    andq %r10, %r15
; CHECK-NEXT:    leaq (%r15,%r12,4), %r15
; CHECK-NEXT:    movq %r15, %r12
; CHECK-NEXT:    andq %r14, %r12
; CHECK-NEXT:    shrq %r15
; CHECK-NEXT:    andq %r14, %r15
; CHECK-NEXT:    leaq (%r15,%r12,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    bswapq %rbx
; CHECK-NEXT:    movq %rbx, %r15
; CHECK-NEXT:    shrq $4, %r15
; CHECK-NEXT:    andq %rsi, %r15
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    shlq $4, %rbx
; CHECK-NEXT:    orq %r15, %rbx
; CHECK-NEXT:    movq %rbx, %r15
; CHECK-NEXT:    andq %r10, %r15
; CHECK-NEXT:    shrq $2, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    leaq (%rbx,%r15,4), %rbx
; CHECK-NEXT:    movq %rbx, %r15
; CHECK-NEXT:    andq %r14, %r15
; CHECK-NEXT:    shrq %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    leaq (%rbx,%r15,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    shrq $4, %rbx
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rbx, %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,4), %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    shrq %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    shrq $4, %rbx
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rbx, %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,4), %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    shrq %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    shrq $4, %rbx
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rbx, %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,4), %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    shrq %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    shrq $4, %rbx
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rbx, %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,4), %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    shrq %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    shrq $4, %rbx
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rbx, %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,4), %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    shrq %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    shrq $4, %rbx
; CHECK-NEXT:    andq %rsi, %rbx
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rbx, %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r10, %rbx
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,4), %rdi
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    andq %r14, %rbx
; CHECK-NEXT:    shrq %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    leaq (%rdi,%rbx,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    bswapq %rdi
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    shrq $4, %rax
; CHECK-NEXT:    andq %rsi, %rax
; CHECK-NEXT:    andq %rsi, %rdi
; CHECK-NEXT:    shlq $4, %rdi
; CHECK-NEXT:    orq %rax, %rdi
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    andq %r10, %rax
; CHECK-NEXT:    shrq $2, %rdi
; CHECK-NEXT:    andq %r10, %rdi
; CHECK-NEXT:    leaq (%rdi,%rax,4), %rax
; CHECK-NEXT:    movq %rax, %rdi
; CHECK-NEXT:    andq %r14, %rdi
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    andq %r14, %rax
; CHECK-NEXT:    leaq (%rax,%rdi,2), %rdi
; CHECK-NEXT:    bswapq %r9
; CHECK-NEXT:    movq %r9, %rax
; CHECK-NEXT:    shrq $4, %rax
; CHECK-NEXT:    andq %rsi, %rax
; CHECK-NEXT:    andq %rsi, %r9
; CHECK-NEXT:    shlq $4, %r9
; CHECK-NEXT:    orq %rax, %r9
; CHECK-NEXT:    movq %r9, %rax
; CHECK-NEXT:    andq %r10, %rax
; CHECK-NEXT:    shrq $2, %r9
; CHECK-NEXT:    andq %r10, %r9
; CHECK-NEXT:    leaq (%r9,%rax,4), %rax
; CHECK-NEXT:    movq %rax, %r9
; CHECK-NEXT:    andq %r14, %r9
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    andq %r14, %rax
; CHECK-NEXT:    leaq (%rax,%r9,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    bswapq %r8
; CHECK-NEXT:    movq %r8, %rax
; CHECK-NEXT:    shrq $4, %rax
; CHECK-NEXT:    andq %rsi, %rax
; CHECK-NEXT:    andq %rsi, %r8
; CHECK-NEXT:    shlq $4, %r8
; CHECK-NEXT:    orq %rax, %r8
; CHECK-NEXT:    movq %r8, %rax
; CHECK-NEXT:    andq %r10, %rax
; CHECK-NEXT:    shrq $2, %r8
; CHECK-NEXT:    andq %r10, %r8
; CHECK-NEXT:    leaq (%r8,%rax,4), %rax
; CHECK-NEXT:    movq %rax, %r8
; CHECK-NEXT:    andq %r14, %r8
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    andq %r14, %rax
; CHECK-NEXT:    leaq (%rax,%r8,2), %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    bswapq %rcx
; CHECK-NEXT:    movq %rcx, %rax
; CHECK-NEXT:    shrq $4, %rax
; CHECK-NEXT:    andq %rsi, %rax
; CHECK-NEXT:    andq %rsi, %rcx
; CHECK-NEXT:    shlq $4, %rcx
; CHECK-NEXT:    orq %rax, %rcx
; CHECK-NEXT:    movq %rcx, %rax
; CHECK-NEXT:    andq %r10, %rax
; CHECK-NEXT:    shrq $2, %rcx
; CHECK-NEXT:    andq %r10, %rcx
; CHECK-NEXT:    leaq (%rcx,%rax,4), %rax
; CHECK-NEXT:    movq %rax, %rcx
; CHECK-NEXT:    andq %r14, %rcx
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    andq %r14, %rax
; CHECK-NEXT:    leaq (%rax,%rcx,2), %rbx
; CHECK-NEXT:    bswapq %rdx
; CHECK-NEXT:    movq %rdx, %rax
; CHECK-NEXT:    shrq $4, %rax
; CHECK-NEXT:    andq %rsi, %rax
; CHECK-NEXT:    andq %rsi, %rdx
; CHECK-NEXT:    shlq $4, %rdx
; CHECK-NEXT:    orq %rax, %rdx
; CHECK-NEXT:    movq %rdx, %rax
; CHECK-NEXT:    andq %r10, %rax
; CHECK-NEXT:    shrq $2, %rdx
; CHECK-NEXT:    andq %r10, %rdx
; CHECK-NEXT:    leaq (%rdx,%rax,4), %rax
; CHECK-NEXT:    movq %rax, %rdx
; CHECK-NEXT:    andq %r14, %rdx
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    andq %r14, %rax
; CHECK-NEXT:    leaq (%rax,%rdx,2), %rdx
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rcx # 8-byte Reload
; CHECK-NEXT:    bswapq %rcx
; CHECK-NEXT:    movq %rcx, %rax
; CHECK-NEXT:    shrq $4, %rax
; CHECK-NEXT:    andq %rsi, %rax
; CHECK-NEXT:    andq %rsi, %rcx
; CHECK-NEXT:    shlq $4, %rcx
; CHECK-NEXT:    orq %rax, %rcx
; CHECK-NEXT:    movq %rcx, %rax
; CHECK-NEXT:    andq %r10, %rax
; CHECK-NEXT:    shrq $2, %rcx
; CHECK-NEXT:    andq %r10, %rcx
; CHECK-NEXT:    leaq (%rcx,%rax,4), %rax
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    andq %r14, %rsi
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    andq %r14, %rax
; CHECK-NEXT:    leaq (%rax,%rsi,2), %rsi
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r10 # 8-byte Reload
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rax # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %rax, %r10
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rcx # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %rcx, %rax
; CHECK-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rbp # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %rbp, %rcx
; CHECK-NEXT:    movq %rcx, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r13 # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %r13, %rbp
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r12 # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %r12, %r13
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r15 # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %r15, %r12
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r14 # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %r14, %r15
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r11 # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %r11, %r14
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r9 # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %r9, %r11
; CHECK-NEXT:    movq %rdi, %r8
; CHECK-NEXT:    shrdq $24, %rdi, %r9
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rdi # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %rdi, %r8
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rcx # 8-byte Reload
; CHECK-NEXT:    shrdq $24, %rcx, %rdi
; CHECK-NEXT:    shrdq $24, %rbx, %rcx
; CHECK-NEXT:    shrdq $24, %rdx, %rbx
; CHECK-NEXT:    shrdq $24, %rsi, %rdx
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rax # 8-byte Reload
; CHECK-NEXT:    movq %rdx, 112(%rax)
; CHECK-NEXT:    movq %rbx, 104(%rax)
; CHECK-NEXT:    movq %rcx, 96(%rax)
; CHECK-NEXT:    movq %rdi, 88(%rax)
; CHECK-NEXT:    movq %r8, 80(%rax)
; CHECK-NEXT:    movq %r9, 72(%rax)
; CHECK-NEXT:    movq %r11, 64(%rax)
; CHECK-NEXT:    movq %r14, 56(%rax)
; CHECK-NEXT:    movq %r15, 48(%rax)
; CHECK-NEXT:    movq %r12, 40(%rax)
; CHECK-NEXT:    movq %r13, 32(%rax)
; CHECK-NEXT:    movq %rbp, 24(%rax)
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rcx # 8-byte Reload
; CHECK-NEXT:    movq %rcx, 16(%rax)
; CHECK-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rcx # 8-byte Reload
; CHECK-NEXT:    movq %rcx, 8(%rax)
; CHECK-NEXT:    movq %r10, (%rax)
; CHECK-NEXT:    movq %rsi, %rcx
; CHECK-NEXT:    shrq $56, %rsi
; CHECK-NEXT:    movb %sil, 124(%rax)
; CHECK-NEXT:    shrq $24, %rcx
; CHECK-NEXT:    movl %ecx, 120(%rax)
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %r12
; CHECK-NEXT:    popq %r13
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    retq
  %Z = call i1000 @llvm.bitreverse.i1000(i1000 %A)
  ret i1000 %Z
}

declare i1000 @llvm.bitreverse.i1000(i1000)
