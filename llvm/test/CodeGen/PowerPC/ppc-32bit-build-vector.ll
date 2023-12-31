; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc -mcpu=pwr8 < %s |\
; RUN: FileCheck %s --check-prefix=32BIT

; RUN: llc -verify-machineinstrs -mtriple=powerpc64 -mcpu=pwr8 < %s |\
; RUN: FileCheck %s --check-prefix=64BIT

define dso_local fastcc void @BuildVectorICE() unnamed_addr {
; 32BIT-LABEL: BuildVectorICE:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    .cfi_def_cfa_offset 64
; 32BIT-NEXT:    li 4, .LCPI0_0@l
; 32BIT-NEXT:    lis 5, .LCPI0_0@ha
; 32BIT-NEXT:    lxvw4x 34, 0, 3
; 32BIT-NEXT:    li 3, 0
; 32BIT-NEXT:    addi 6, 1, 48
; 32BIT-NEXT:    li 7, 0
; 32BIT-NEXT:    lxvw4x 35, 5, 4
; 32BIT-NEXT:    addi 4, 1, 32
; 32BIT-NEXT:    addi 5, 1, 16
; 32BIT-NEXT:    .p2align 4
; 32BIT-NEXT:  .LBB0_1: # %while.body
; 32BIT-NEXT:    #
; 32BIT-NEXT:    stw 3, 32(1)
; 32BIT-NEXT:    stw 7, 16(1)
; 32BIT-NEXT:    lxvw4x 36, 0, 4
; 32BIT-NEXT:    lxvw4x 37, 0, 5
; 32BIT-NEXT:    vperm 4, 5, 4, 3
; 32BIT-NEXT:    vadduwm 4, 2, 4
; 32BIT-NEXT:    xxspltw 37, 36, 1
; 32BIT-NEXT:    vadduwm 4, 4, 5
; 32BIT-NEXT:    stxvw4x 36, 0, 6
; 32BIT-NEXT:    lwz 7, 48(1)
; 32BIT-NEXT:    b .LBB0_1
;
; 64BIT-LABEL: BuildVectorICE:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    lxvw4x 34, 0, 3
; 64BIT-NEXT:    li 3, 0
; 64BIT-NEXT:    rldimi 3, 3, 32, 0
; 64BIT-NEXT:    mtfprd 0, 3
; 64BIT-NEXT:    li 3, 0
; 64BIT-NEXT:    .p2align 4
; 64BIT-NEXT:  .LBB0_1: # %while.body
; 64BIT-NEXT:    #
; 64BIT-NEXT:    li 4, 0
; 64BIT-NEXT:    rldimi 4, 3, 32, 0
; 64BIT-NEXT:    mtfprd 1, 4
; 64BIT-NEXT:    xxmrghd 35, 1, 0
; 64BIT-NEXT:    vadduwm 3, 2, 3
; 64BIT-NEXT:    xxspltw 36, 35, 1
; 64BIT-NEXT:    vadduwm 3, 3, 4
; 64BIT-NEXT:    xxsldwi 1, 35, 35, 3
; 64BIT-NEXT:    mffprwz 3, 1
; 64BIT-NEXT:    b .LBB0_1
    entry:
     br label %while.body
     while.body:                                       ; preds = %while.body, %entry
     %newelement = phi i32 [ 0, %entry ], [ %5, %while.body ]
     %0 = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %newelement, i32 0
     %1 = load <4 x i32>, ptr undef, align 1
     %2 = add <4 x i32> %1, %0
     %3 = shufflevector <4 x i32> %2, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
     %4 = add <4 x i32> %2, %3
     %5 = extractelement <4 x i32> %4, i32 0
     br label %while.body
}
