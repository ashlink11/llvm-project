; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -verify-machineinstrs -csky-no-aliases -mattr=+2e3 < %s -mtriple=csky | FileCheck %s
; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky | FileCheck %s --check-prefix=GENERIC

;; This file shows if a multiplication can be simplified to an addition/subtraction
;; of left shifts.

define i32 @mul_i32_4097(i32 %x) {
; CHECK-LABEL: mul_i32_4097:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 12
; CHECK-NEXT:    addu16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_4097:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    addu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, 4097
  ret i32 %y
}

define i32 @mul_i32_4095(i32 %x) {
; CHECK-LABEL: mul_i32_4095:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 12
; CHECK-NEXT:    subu16 a0, a1, a0
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_4095:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    subu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, 4095
  ret i32 %y
}

define i32 @mul_i32_minus_4095(i32 %x) {
; CHECK-LABEL: mul_i32_minus_4095:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 12
; CHECK-NEXT:    subu16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_minus_4095:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    subu16 a0, a0, a1
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, -4095
  ret i32 %y
}

define i32 @mul_i32_131074(i32 %x) {
; CHECK-LABEL: mul_i32_131074:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 17
; CHECK-NEXT:    ixh32 a0, a1, a0
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_131074:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    st16.w l0, (sp, 0) # 4-byte Folded Spill
; GENERIC-NEXT:    .cfi_offset l0, -4
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 8
; GENERIC-NEXT:    movi16 a1, 0
; GENERIC-NEXT:    lsli16 a2, a1, 24
; GENERIC-NEXT:    movi16 a3, 2
; GENERIC-NEXT:    lsli16 l0, a3, 16
; GENERIC-NEXT:    or16 l0, a2
; GENERIC-NEXT:    lsli16 a1, a1, 8
; GENERIC-NEXT:    or16 a1, l0
; GENERIC-NEXT:    or16 a1, a3
; GENERIC-NEXT:    mult16 a0, a1
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    ld16.w l0, (sp, 0) # 4-byte Folded Reload
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, 131074
  ret i32 %y
}

define i32 @mul_i32_131076(i32 %x) {
; CHECK-LABEL: mul_i32_131076:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 17
; CHECK-NEXT:    ixw32 a0, a1, a0
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_131076:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    movi16 a1, 0
; GENERIC-NEXT:    lsli16 a2, a1, 24
; GENERIC-NEXT:    movi16 a3, 2
; GENERIC-NEXT:    lsli16 a3, a3, 16
; GENERIC-NEXT:    or16 a3, a2
; GENERIC-NEXT:    lsli16 a1, a1, 8
; GENERIC-NEXT:    or16 a1, a3
; GENERIC-NEXT:    movi16 a2, 4
; GENERIC-NEXT:    or16 a2, a1
; GENERIC-NEXT:    mult16 a0, a2
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, 131076
  ret i32 %y
}

define i32 @mul_i32_131080(i32 %x) {
; CHECK-LABEL: mul_i32_131080:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 17
; CHECK-NEXT:    ixd32 a0, a1, a0
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_131080:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    movi16 a1, 0
; GENERIC-NEXT:    lsli16 a2, a1, 24
; GENERIC-NEXT:    movi16 a3, 2
; GENERIC-NEXT:    lsli16 a3, a3, 16
; GENERIC-NEXT:    or16 a3, a2
; GENERIC-NEXT:    lsli16 a1, a1, 8
; GENERIC-NEXT:    or16 a1, a3
; GENERIC-NEXT:    movi16 a2, 8
; GENERIC-NEXT:    or16 a2, a1
; GENERIC-NEXT:    mult16 a0, a2
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, 131080
  ret i32 %y
}

define i16 @mul_i16_4097(i16 %x) {
; CHECK-LABEL: mul_i16_4097:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 12
; CHECK-NEXT:    addu16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i16_4097:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    addu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i16 %x, 4097
  ret i16 %y
}

define i16 @mul_i16_4095(i16 %x) {
; CHECK-LABEL: mul_i16_4095:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 12
; CHECK-NEXT:    subu16 a0, a1, a0
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i16_4095:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    subu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i16 %x, 4095
  ret i16 %y
}

define i16 @mul_i16_minus_4095(i16 %x) {
; CHECK-LABEL: mul_i16_minus_4095:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 12
; CHECK-NEXT:    subu16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i16_minus_4095:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    subu16 a0, a0, a1
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i16 %x, -4095
  ret i16 %y
}

define i8 @mul_i8_65(i8 %x) {
; CHECK-LABEL: mul_i8_65:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 6
; CHECK-NEXT:    addu16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i8_65:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 6
; GENERIC-NEXT:    addu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i8 %x, 65
  ret i8 %y
}

define i8 @mul_i8_63(i8 %x) {
; CHECK-LABEL: mul_i8_63:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 6
; CHECK-NEXT:    subu16 a0, a1, a0
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i8_63:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 6
; GENERIC-NEXT:    subu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i8 %x, 63
  ret i8 %y
}

define i8 @mul_i8_minus_63(i8 %x) {
; CHECK-LABEL: mul_i8_minus_63:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lsli16 a1, a0, 6
; CHECK-NEXT:    subu16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i8_minus_63:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 6
; GENERIC-NEXT:    subu16 a0, a0, a1
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i8 %x, -63
  ret i8 %y
}

define i32 @mul_i32_minus_4097(i32 %x) {
; CHECK-LABEL: mul_i32_minus_4097:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movih32 a1, 65535
; CHECK-NEXT:    ori32 a1, a1, 61439
; CHECK-NEXT:    mult16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i32_minus_4097:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    addu16 a0, a1, a0
; GENERIC-NEXT:    movi16 a1, 0
; GENERIC-NEXT:    subu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i32 %x, -4097
  ret i32 %y
}

define i16 @mul_i16_minus_4097(i16 %x) {
; CHECK-LABEL: mul_i16_minus_4097:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movih32 a1, 65535
; CHECK-NEXT:    ori32 a1, a1, 61439
; CHECK-NEXT:    mult16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i16_minus_4097:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 12
; GENERIC-NEXT:    addu16 a0, a1, a0
; GENERIC-NEXT:    movi16 a1, 0
; GENERIC-NEXT:    subu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i16 %x, -4097
  ret i16 %y
}

define i8 @mul_i8_minus_65(i8 %x) {
; CHECK-LABEL: mul_i8_minus_65:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movih32 a1, 65535
; CHECK-NEXT:    ori32 a1, a1, 65471
; CHECK-NEXT:    mult16 a0, a1
; CHECK-NEXT:    rts16
;
; GENERIC-LABEL: mul_i8_minus_65:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    .cfi_def_cfa_offset 0
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 4
; GENERIC-NEXT:    lsli16 a1, a0, 6
; GENERIC-NEXT:    addu16 a0, a1, a0
; GENERIC-NEXT:    movi16 a1, 0
; GENERIC-NEXT:    subu16 a0, a1, a0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    rts16
entry:
  %y = mul nsw i8 %x, -65
  ret i8 %y
}

;; This case can not be optimized, due to the data type exceeds.
define i64 @mul_i64_4097(i64 %x) {
; CHECK-LABEL: mul_i64_4097:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subi16 sp, sp, 4
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset lr, -4
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    movi32 a2, 4097
; CHECK-NEXT:    movi16 a3, 0
; CHECK-NEXT:    jsri32 [.LCPI15_0]
; CHECK-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-NEXT:    addi16 sp, sp, 4
; CHECK-NEXT:    rts16
; CHECK-NEXT:    .p2align 1
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  .LCPI15_0:
; CHECK-NEXT:    .long __muldi3
;
; GENERIC-LABEL: mul_i64_4097:
; GENERIC:       # %bb.0: # %entry
; GENERIC-NEXT:    subi16 sp, sp, 8
; GENERIC-NEXT:    .cfi_def_cfa_offset 8
; GENERIC-NEXT:    st16.w l0, (sp, 4) # 4-byte Folded Spill
; GENERIC-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; GENERIC-NEXT:    .cfi_offset l0, -4
; GENERIC-NEXT:    .cfi_offset lr, -8
; GENERIC-NEXT:    subi16 sp, sp, 4
; GENERIC-NEXT:    .cfi_def_cfa_offset 12
; GENERIC-NEXT:    movi16 a2, 0
; GENERIC-NEXT:    lsli16 a3, a2, 24
; GENERIC-NEXT:    lsli16 a2, a2, 16
; GENERIC-NEXT:    or16 a2, a3
; GENERIC-NEXT:    movi16 a3, 16
; GENERIC-NEXT:    lsli16 a3, a3, 8
; GENERIC-NEXT:    or16 a3, a2
; GENERIC-NEXT:    movi16 a2, 1
; GENERIC-NEXT:    or16 a2, a3
; GENERIC-NEXT:    lrw32 l0, [.LCPI15_0]
; GENERIC-NEXT:    movi16 a3, 0
; GENERIC-NEXT:    jsr16 l0
; GENERIC-NEXT:    addi16 sp, sp, 4
; GENERIC-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; GENERIC-NEXT:    ld16.w l0, (sp, 4) # 4-byte Folded Reload
; GENERIC-NEXT:    addi16 sp, sp, 8
; GENERIC-NEXT:    rts16
; GENERIC-NEXT:    .p2align 1
; GENERIC-NEXT:  # %bb.1:
; GENERIC-NEXT:    .p2align 2, 0x0
; GENERIC-NEXT:  .LCPI15_0:
; GENERIC-NEXT:    .long __muldi3
entry:
  %y = mul nsw i64 %x, 4097
  ret i64 %y
}
