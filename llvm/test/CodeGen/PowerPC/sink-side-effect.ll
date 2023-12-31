; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64le -mcpu=pwr9 -verify-machineinstrs -disable-cgp-delete-phis < %s | FileCheck %s

define double @zot(ptr %arg, ptr %arg1, ptr %arg2) {
; CHECK-LABEL: zot:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    bc 12, 20, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %bb3
; CHECK-NEXT:    lhz 5, 0(5)
; CHECK-NEXT:    rlwinm. 5, 5, 28, 30, 31
; CHECK-NEXT:  .LBB0_2: # %bb10
; CHECK-NEXT:    lfs 0, 0(4)
; CHECK-NEXT:    lwz 3, 0(3)
; CHECK-NEXT:    li 4, 2
; CHECK-NEXT:    fmr 1, 0
; CHECK-NEXT:    b .LBB0_4
; CHECK-NEXT:    .p2align 5
; CHECK-NEXT:  .LBB0_3: # %bb17
; CHECK-NEXT:    #
; CHECK-NEXT:    addi 4, 4, 1
; CHECK-NEXT:  .LBB0_4: # %bb17
; CHECK-NEXT:    #
; CHECK-NEXT:    cmpw 4, 3
; CHECK-NEXT:    bge 0, .LBB0_3
; CHECK-NEXT:  # %bb.5:
; CHECK-NEXT:    xsmuldp 1, 1, 0
; CHECK-NEXT:    b .LBB0_3
bb:
  %tmp = load i32, ptr %arg, align 8
  br i1 undef, label %bb9, label %bb3

bb3:
  %tmp4 = load i16, ptr %arg2, align 4
  %tmp5 = lshr i16 %tmp4, 4
  %tmp6 = and i16 %tmp5, 3
  %tmp7 = zext i16 %tmp6 to i32
  %tmp8 = icmp eq i16 %tmp6, 0
  br i1 %tmp8, label %bb9, label %bb10

bb9:
  br label %bb10

bb10:
  %tmp11 = phi i32 [ undef, %bb9 ], [ %tmp7, %bb3 ]
  %tmp12 = icmp sgt i32 %tmp11, 1
  br label %bb13

bb13:
  %tmp14 = load float, ptr %arg1, align 4
  %tmp15 = fpext float %tmp14 to double
  br label %bb16

bb16:
  br label %bb17

bb17:
  %tmp18 = phi i32 [ %tmp23, %bb17 ], [ 2, %bb16 ]
  %tmp19 = phi double [ %tmp22, %bb17 ], [ %tmp15, %bb16 ]
  %tmp20 = icmp slt i32 %tmp18, %tmp
  %tmp21 = fmul fast double %tmp19, %tmp15
  %tmp22 = select i1 %tmp20, double %tmp21, double %tmp19
  %tmp23 = add nuw i32 %tmp18, 1
  br label %bb17
}

declare double @ham()
