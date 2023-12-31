; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s --check-prefixes=X64

define i32 @t1(ptr %X, i32 %i) {
; X86-LABEL: t1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzbl %cl, %ecx
; X86-NEXT:    movl (%eax,%ecx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: t1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movzbl %sil, %eax
; X64-NEXT:    movl (%rdi,%rax,4), %eax
; X64-NEXT:    retq
entry:
  %tmp2 = shl i32 %i, 2
  %tmp4 = and i32 %tmp2, 1020
  %tmp7 = getelementptr i8, ptr %X, i32 %tmp4
  %tmp9 = load i32, ptr %tmp7
  ret i32 %tmp9
}

define i32 @t2(ptr %X, i32 %i) {
; X86-LABEL: t2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl %cx, %ecx
; X86-NEXT:    movl (%eax,%ecx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: t2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movzwl %si, %eax
; X64-NEXT:    movl (%rdi,%rax,4), %eax
; X64-NEXT:    retq
entry:
  %tmp2 = shl i32 %i, 1
  %tmp4 = and i32 %tmp2, 131070
  %tmp7 = getelementptr i16, ptr %X, i32 %tmp4
  %tmp9 = load i32, ptr %tmp7
  ret i32 %tmp9
}

; This case is tricky. The lshr followed by a gep will produce a lshr followed
; by an and to remove the low bits. This can be simplified by doing the lshr by
; a greater constant and using the addressing mode to scale the result back up.
; To make matters worse, because of the two-phase zext of %i and their reuse in
; the function, the DAG can get confusing trying to re-use both of them and
; prevent easy analysis of the mask in order to match this.
define i32 @t3(ptr %i.ptr, ptr %arr) {
; X86-LABEL: t3:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl (%eax), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    shrl $11, %edx
; X86-NEXT:    addl (%ecx,%edx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: t3:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movzwl (%rdi), %eax
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    shrl $11, %ecx
; X64-NEXT:    addl (%rsi,%rcx,4), %eax
; X64-NEXT:    retq
entry:
  %i = load i16, ptr %i.ptr
  %i.zext = zext i16 %i to i32
  %index = lshr i32 %i.zext, 11
  %val.ptr = getelementptr inbounds i32, ptr %arr, i32 %index
  %val = load i32, ptr %val.ptr
  %sum = add i32 %val, %i.zext
  ret i32 %sum
}

; A version of @t3 that has more zero extends and more re-use of intermediate
; values. This exercise slightly different bits of canonicalization.
define i32 @t4(ptr %i.ptr, ptr %arr) {
; X86-LABEL: t4:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl (%eax), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    shrl $11, %edx
; X86-NEXT:    addl (%ecx,%edx,4), %eax
; X86-NEXT:    addl %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t4:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movzwl (%rdi), %eax
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    shrl $11, %ecx
; X64-NEXT:    addl (%rsi,%rcx,4), %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    retq
entry:
  %i = load i16, ptr %i.ptr
  %i.zext = zext i16 %i to i32
  %index = lshr i32 %i.zext, 11
  %index.zext = zext i32 %index to i64
  %val.ptr = getelementptr inbounds i32, ptr %arr, i64 %index.zext
  %val = load i32, ptr %val.ptr
  %sum.1 = add i32 %val, %i.zext
  %sum.2 = add i32 %sum.1, %index
  ret i32 %sum.2
}

define i8 @t5(ptr %X, i32 %i) {
; X86-LABEL: t5:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $-14, %ecx
; X86-NEXT:    movzbl (%eax,%ecx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: t5:
; X64:       # %bb.0: # %entry
; X64-NEXT:    shll $2, %esi
; X64-NEXT:    andl $-56, %esi
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movzbl (%rdi,%rax), %eax
; X64-NEXT:    retq
entry:
  %tmp2 = shl i32 %i, 2
  %tmp4 = and i32 %tmp2, -56
  %tmp7 = getelementptr i8, ptr %X, i32 %tmp4
  %tmp9 = load i8, ptr %tmp7
  ret i8 %tmp9
}

define i8 @t6(ptr %X, i32 %i) {
; X86-LABEL: t6:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $-255, %ecx
; X86-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzbl (%eax,%ecx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: t6:
; X64:       # %bb.0: # %entry
; X64-NEXT:    shll $2, %esi
; X64-NEXT:    andl $-1020, %esi # imm = 0xFC04
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movzbl (%rdi,%rax), %eax
; X64-NEXT:    retq
entry:
  %tmp2 = shl i32 %i, 2
  %tmp4 = and i32 %tmp2, -1020
  %tmp7 = getelementptr i8, ptr %X, i32 %tmp4
  %tmp9 = load i8, ptr %tmp7
  ret i8 %tmp9
}
