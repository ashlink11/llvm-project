; Test strict vector subtraction on z14.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z14 | FileCheck %s

declare float @llvm.experimental.constrained.fsub.f32(float, float, metadata, metadata)
declare <4 x float> @llvm.experimental.constrained.fsub.v4f32(<4 x float>, <4 x float>, metadata, metadata)
declare <1 x fp128> @llvm.experimental.constrained.fsub.v1f128(<1 x fp128>, <1 x fp128>, metadata, metadata)

; Test a v4f32 subtraction.
define <4 x float> @f6(<4 x float> %dummy, <4 x float> %val1,
                       <4 x float> %val2) #0 {
; CHECK-LABEL: f6:
; CHECK: vfssb %v24, %v26, %v28
; CHECK: br %r14
  %ret = call <4 x float> @llvm.experimental.constrained.fsub.v4f32(
                        <4 x float> %val1, <4 x float> %val2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict") #0
  ret <4 x float> %ret
}

; Test an f32 subtraction that uses vector registers.
define float @f7(<4 x float> %val1, <4 x float> %val2) #0 {
; CHECK-LABEL: f7:
; CHECK: wfssb %f0, %v24, %v26
; CHECK: br %r14
  %scalar1 = extractelement <4 x float> %val1, i32 0
  %scalar2 = extractelement <4 x float> %val2, i32 0
  %ret = call float @llvm.experimental.constrained.fsub.f32(
                        float %scalar1, float %scalar2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict") #0
  ret float %ret
}

; Test a v1f128 subtraction.
define <1 x fp128> @f8(<1 x fp128> %dummy, <1 x fp128> %val1,
                       <1 x fp128> %val2) #0 {
; CHECK-LABEL: f8:
; CHECK: wfsxb %v24, %v26, %v28
; CHECK: br %r14
  %ret = call <1 x fp128> @llvm.experimental.constrained.fsub.v1f128(
                        <1 x fp128> %val1, <1 x fp128> %val2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict") #0
  ret <1 x fp128> %ret
}

attributes #0 = { strictfp }
