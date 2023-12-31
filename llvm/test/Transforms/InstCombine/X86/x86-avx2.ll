; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -mtriple=x86_64-unknown-unknown -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Verify that instcombine is able to fold identity shuffles.

define <8 x i32> @identity_test_vpermd(<8 x i32> %a0) {
; CHECK-LABEL: @identity_test_vpermd(
; CHECK-NEXT:    ret <8 x i32> [[A0:%.*]]
;
  %a = tail call <8 x i32> @llvm.x86.avx2.permd(<8 x i32> %a0, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>)
  ret <8 x i32> %a
}

define <8 x float> @identity_test_vpermps(<8 x float> %a0) {
; CHECK-LABEL: @identity_test_vpermps(
; CHECK-NEXT:    ret <8 x float> [[A0:%.*]]
;
  %a = tail call <8 x float> @llvm.x86.avx2.permps(<8 x float> %a0, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>)
  ret <8 x float> %a
}

; Instcombine should be able to fold the following shuffle to a builtin shufflevector
; with a shuffle mask of all zeroes.

define <8 x i32> @zero_test_vpermd(<8 x i32> %a0) {
; CHECK-LABEL: @zero_test_vpermd(
; CHECK-NEXT:    [[A:%.*]] = shufflevector <8 x i32> [[A0:%.*]], <8 x i32> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    ret <8 x i32> [[A]]
;
  %a = tail call <8 x i32> @llvm.x86.avx2.permd(<8 x i32> %a0, <8 x i32> zeroinitializer)
  ret <8 x i32> %a
}

define <8 x float> @zero_test_vpermps(<8 x float> %a0) {
; CHECK-LABEL: @zero_test_vpermps(
; CHECK-NEXT:    [[A:%.*]] = shufflevector <8 x float> [[A0:%.*]], <8 x float> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    ret <8 x float> [[A]]
;
  %a = tail call <8 x float> @llvm.x86.avx2.permps(<8 x float> %a0, <8 x i32> zeroinitializer)
  ret <8 x float> %a
}

; Verify that instcombine is able to fold constant shuffles.

define <8 x i32> @shuffle_test_vpermd(<8 x i32> %a0) {
; CHECK-LABEL: @shuffle_test_vpermd(
; CHECK-NEXT:    [[A:%.*]] = shufflevector <8 x i32> [[A0:%.*]], <8 x i32> poison, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    ret <8 x i32> [[A]]
;
  %a = tail call <8 x i32> @llvm.x86.avx2.permd(<8 x i32> %a0, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>)
  ret <8 x i32> %a
}

define <8 x float> @shuffle_test_vpermps(<8 x float> %a0) {
; CHECK-LABEL: @shuffle_test_vpermps(
; CHECK-NEXT:    [[A:%.*]] = shufflevector <8 x float> [[A0:%.*]], <8 x float> poison, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    ret <8 x float> [[A]]
;
  %a = tail call <8 x float> @llvm.x86.avx2.permps(<8 x float> %a0, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>)
  ret <8 x float> %a
}

; Verify that instcombine is able to fold constant shuffles with undef mask elements.

define <8 x i32> @undef_test_vpermd(<8 x i32> %a0) {
; CHECK-LABEL: @undef_test_vpermd(
; CHECK-NEXT:    [[A:%.*]] = shufflevector <8 x i32> [[A0:%.*]], <8 x i32> poison, <8 x i32> <i32 poison, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    ret <8 x i32> [[A]]
;
  %a = tail call <8 x i32> @llvm.x86.avx2.permd(<8 x i32> %a0, <8 x i32> <i32 undef, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>)
  ret <8 x i32> %a
}

define <8 x float> @undef_test_vpermps(<8 x float> %a0) {
; CHECK-LABEL: @undef_test_vpermps(
; CHECK-NEXT:    [[A:%.*]] = shufflevector <8 x float> [[A0:%.*]], <8 x float> poison, <8 x i32> <i32 poison, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    ret <8 x float> [[A]]
;
  %a = tail call <8 x float> @llvm.x86.avx2.permps(<8 x float> %a0, <8 x i32> <i32 undef, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>)
  ret <8 x float> %a
}

; Verify simplify demanded elts.

define <8 x i32> @elts_test_vpermd(<8 x i32> %a0, i32 %a1) {
; CHECK-LABEL: @elts_test_vpermd(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[A0:%.*]], <8 x i32> poison, <8 x i32> <i32 poison, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x i32> [[TMP1]]
;
  %1 = insertelement <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, i32 %a1, i32 0
  %2 = tail call <8 x i32> @llvm.x86.avx2.permd(<8 x i32> %a0, <8 x i32> %1)
  %3 = shufflevector <8 x i32> %2, <8 x i32> undef, <8 x i32> <i32 undef, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %3
}

define <8 x float> @elts_test_vpermps(<8 x float> %a0, <8 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpermps(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <8 x float> @llvm.x86.avx2.permps(<8 x float> [[A0:%.*]], <8 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    ret <8 x float> [[TMP2]]
;
  %1 = insertelement <8 x i32> %a1, i32 0, i32 7
  %2 = tail call <8 x float> @llvm.x86.avx2.permps(<8 x float> %a0, <8 x i32> %1)
  %3 = shufflevector <8 x float> %2, <8 x float> undef, <8 x i32> zeroinitializer
  ret <8 x float> %3
}

define <2 x i64> @elts_test_vpsllvq(<2 x i64> %a0, <2 x i64> %a1) {
; CHECK-LABEL: @elts_test_vpsllvq(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.avx2.psllv.q(<2 x i64> [[A0:%.*]], <2 x i64> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i64> [[TMP1]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    ret <2 x i64> [[TMP2]]
;
  %1 = insertelement <2 x i64> %a1, i64 0, i64 1
  %2 = tail call <2 x i64> @llvm.x86.avx2.psllv.q(<2 x i64> %a0, <2 x i64> %1)
  %3 = shufflevector <2 x i64> %2, <2 x i64> undef, <2 x i32> zeroinitializer
  ret <2 x i64> %3
}

define <2 x i64> @elts_test_vpsrlvq(<2 x i64> %a0, <2 x i64> %a1) {
; CHECK-LABEL: @elts_test_vpsrlvq(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.avx2.psrlv.q(<2 x i64> [[A0:%.*]], <2 x i64> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i64> [[TMP1]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    ret <2 x i64> [[TMP2]]
;
  %1 = insertelement <2 x i64> %a1, i64 0, i64 1
  %2 = tail call <2 x i64> @llvm.x86.avx2.psrlv.q(<2 x i64> %a0, <2 x i64> %1)
  %3 = shufflevector <2 x i64> %2, <2 x i64> undef, <2 x i32> zeroinitializer
  ret <2 x i64> %3
}

define <4 x i64> @elts_test_vpsllvq_256(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: @elts_test_vpsllvq_256(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i64> @llvm.x86.avx2.psllv.q.256(<4 x i64> [[A0:%.*]], <4 x i64> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i64> [[TMP1]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i64> [[TMP2]]
;
  %1 = insertelement <4 x i64> %a1, i64 0, i64 2
  %2 = tail call <4 x i64> @llvm.x86.avx2.psllv.q.256(<4 x i64> %a0, <4 x i64> %1)
  %3 = shufflevector <4 x i64> %2, <4 x i64> undef, <4 x i32> zeroinitializer
  ret <4 x i64> %3
}

define <4 x i64> @elts_test_vpsrlvq_256(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: @elts_test_vpsrlvq_256(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i64> @llvm.x86.avx2.psrlv.q.256(<4 x i64> [[A0:%.*]], <4 x i64> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i64> [[TMP1]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i64> [[TMP2]]
;
  %1 = insertelement <4 x i64> %a1, i64 0, i64 3
  %2 = tail call <4 x i64> @llvm.x86.avx2.psrlv.q.256(<4 x i64> %a0, <4 x i64> %1)
  %3 = shufflevector <4 x i64> %2, <4 x i64> undef, <4 x i32> zeroinitializer
  ret <4 x i64> %3
}

define <4 x i32> @elts_test_vpsllvd(<4 x i32> %a0, <4 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpsllvd(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i32> @llvm.x86.avx2.psllv.d(<4 x i32> [[A0:%.*]], <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i32> [[TMP2]]
;
  %1 = insertelement <4 x i32> %a1, i32 0, i64 3
  %2 = tail call <4 x i32> @llvm.x86.avx2.psllv.d(<4 x i32> %a0, <4 x i32> %1)
  %3 = shufflevector <4 x i32> %2, <4 x i32> undef, <4 x i32> zeroinitializer
  ret <4 x i32> %3
}

define <4 x i32> @elts_test_vpsravd(<4 x i32> %a0, <4 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpsravd(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i32> @llvm.x86.avx2.psrav.d(<4 x i32> [[A0:%.*]], <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i32> [[TMP2]]
;
  %1 = insertelement <4 x i32> %a1, i32 0, i64 1
  %2 = tail call <4 x i32> @llvm.x86.avx2.psrav.d(<4 x i32> %a0, <4 x i32> %1)
  %3 = shufflevector <4 x i32> %2, <4 x i32> undef, <4 x i32> zeroinitializer
  ret <4 x i32> %3
}

define <4 x i32> @elts_test_vpsrlvd(<4 x i32> %a0, <4 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpsrlvd(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i32> @llvm.x86.avx2.psrlv.d(<4 x i32> [[A0:%.*]], <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i32> [[TMP2]]
;
  %1 = insertelement <4 x i32> %a1, i32 0, i64 2
  %2 = tail call <4 x i32> @llvm.x86.avx2.psrlv.d(<4 x i32> %a0, <4 x i32> %1)
  %3 = shufflevector <4 x i32> %2, <4 x i32> undef, <4 x i32> zeroinitializer
  ret <4 x i32> %3
}

define <8 x i32> @elts_test_vpsllvd_256(<8 x i32> %a0, <8 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpsllvd_256(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <8 x i32> @llvm.x86.avx2.psllv.d.256(<8 x i32> [[A0:%.*]], <8 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    ret <8 x i32> [[TMP2]]
;
  %1 = insertelement <8 x i32> %a1, i32 0, i64 3
  %2 = tail call <8 x i32> @llvm.x86.avx2.psllv.d.256(<8 x i32> %a0, <8 x i32> %1)
  %3 = shufflevector <8 x i32> %2, <8 x i32> undef, <8 x i32> zeroinitializer
  ret <8 x i32> %3
}

define <8 x i32> @elts_test_vpsravd_256(<8 x i32> %a0, <8 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpsravd_256(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <8 x i32> @llvm.x86.avx2.psrav.d.256(<8 x i32> [[A0:%.*]], <8 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    ret <8 x i32> [[TMP2]]
;
  %1 = insertelement <8 x i32> %a1, i32 0, i64 4
  %2 = tail call <8 x i32> @llvm.x86.avx2.psrav.d.256(<8 x i32> %a0, <8 x i32> %1)
  %3 = shufflevector <8 x i32> %2, <8 x i32> undef, <8 x i32> zeroinitializer
  ret <8 x i32> %3
}

define <8 x i32> @elts_test_vpsrlvd_256(<8 x i32> %a0, <8 x i32> %a1) {
; CHECK-LABEL: @elts_test_vpsrlvd_256(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <8 x i32> @llvm.x86.avx2.psrlv.d.256(<8 x i32> [[A0:%.*]], <8 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    ret <8 x i32> [[TMP2]]
;
  %1 = insertelement <8 x i32> %a1, i32 0, i64 5
  %2 = tail call <8 x i32> @llvm.x86.avx2.psrlv.d.256(<8 x i32> %a0, <8 x i32> %1)
  %3 = shufflevector <8 x i32> %2, <8 x i32> undef, <8 x i32> zeroinitializer
  ret <8 x i32> %3
}

declare <8 x i32> @llvm.x86.avx2.permd(<8 x i32>, <8 x i32>)
declare <8 x float> @llvm.x86.avx2.permps(<8 x float>, <8 x i32>)

declare <2 x i64> @llvm.x86.avx2.psllv.q(<2 x i64>, <2 x i64>)
declare <2 x i64> @llvm.x86.avx2.psrlv.q(<2 x i64>, <2 x i64>)

declare <4 x i64> @llvm.x86.avx2.psllv.q.256(<4 x i64>, <4 x i64>)
declare <4 x i64> @llvm.x86.avx2.psrav.q.256(<4 x i64>, <4 x i64>)
declare <4 x i64> @llvm.x86.avx2.psrlv.q.256(<4 x i64>, <4 x i64>)

declare <4 x i32> @llvm.x86.avx2.psllv.d(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.x86.avx2.psrav.d(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.x86.avx2.psrlv.d(<4 x i32>, <4 x i32>)

declare <8 x i32> @llvm.x86.avx2.psllv.d.256(<8 x i32>, <8 x i32>)
declare <8 x i32> @llvm.x86.avx2.psrav.d.256(<8 x i32>, <8 x i32>)
declare <8 x i32> @llvm.x86.avx2.psrlv.d.256(<8 x i32>, <8 x i32>)
