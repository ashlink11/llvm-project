; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s

; When optimize for size, the constant $858993459 is moved into a register,
; and use that register in following two andl instructions.

define i32 @cnt32_optsize(i32 %x) nounwind readnone optsize {
; CHECK-LABEL: cnt32_optsize:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shrl %eax
; CHECK-NEXT:    andl $1431655765, %eax # imm = 0x55555555
; CHECK-NEXT:    subl %eax, %edi
; CHECK-NEXT:    movl $858993459, %eax # imm = 0x33333333
; CHECK-NEXT:    movl %edi, %ecx
; CHECK-NEXT:    andl %eax, %ecx
; CHECK-NEXT:    shrl $2, %edi
; CHECK-NEXT:    andl %eax, %edi
; CHECK-NEXT:    addl %ecx, %edi
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shrl $4, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    andl $252645135, %eax # imm = 0xF0F0F0F
; CHECK-NEXT:    imull $16843009, %eax, %eax # imm = 0x1010101
; CHECK-NEXT:    shrl $24, %eax
; CHECK-NEXT:    retq
  %cnt = tail call i32 @llvm.ctpop.i32(i32 %x)
  ret i32 %cnt
}

; When optimize for speed, the constant $858993459 can be directly folded into
; two andl instructions.

define i32 @cnt32_optspeed(i32 %x) nounwind readnone {
; CHECK-LABEL: cnt32_optspeed:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shrl %eax
; CHECK-NEXT:    andl $1431655765, %eax # imm = 0x55555555
; CHECK-NEXT:    subl %eax, %edi
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    andl $858993459, %eax # imm = 0x33333333
; CHECK-NEXT:    shrl $2, %edi
; CHECK-NEXT:    andl $858993459, %edi # imm = 0x33333333
; CHECK-NEXT:    addl %eax, %edi
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shrl $4, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    andl $252645135, %eax # imm = 0xF0F0F0F
; CHECK-NEXT:    imull $16843009, %eax, %eax # imm = 0x1010101
; CHECK-NEXT:    shrl $24, %eax
; CHECK-NEXT:    retq
  %cnt = tail call i32 @llvm.ctpop.i32(i32 %x)
  ret i32 %cnt
}

declare i32 @llvm.ctpop.i32(i32) nounwind readnone
