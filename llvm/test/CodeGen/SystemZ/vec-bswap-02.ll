; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; Test stores of byte-swapped vector elements.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z15 | FileCheck %s

declare <8 x i16> @llvm.bswap.v8i16(<8 x i16>)
declare <4 x i32> @llvm.bswap.v4i32(<4 x i32>)
declare <2 x i64> @llvm.bswap.v2i64(<2 x i64>)

; Test v8i16 stores.
define void @f1(<8 x i16> %val, ptr %ptr) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vstbrh %v24, 0(%r2)
; CHECK-NEXT:    br %r14
  %swap = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %val)
  store <8 x i16> %swap, ptr %ptr
  ret void
}

; Test v4i32 stores.
define void @f2(<4 x i32> %val, ptr %ptr) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vstbrf %v24, 0(%r2)
; CHECK-NEXT:    br %r14
  %swap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val)
  store <4 x i32> %swap, ptr %ptr
  ret void
}

; Test v2i64 stores.
define void @f3(<2 x i64> %val, ptr %ptr) {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vstbrg %v24, 0(%r2)
; CHECK-NEXT:    br %r14
  %swap = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %val)
  store <2 x i64> %swap, ptr %ptr
  ret void
}

; Test the highest aligned in-range offset.
define void @f4(<4 x i32> %val, ptr %base) {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vstbrf %v24, 4080(%r2)
; CHECK-NEXT:    br %r14
  %ptr = getelementptr <4 x i32>, ptr %base, i64 255
  %swap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val)
  store <4 x i32> %swap, ptr %ptr
  ret void
}

; Test the highest unaligned in-range offset.
define void @f5(<4 x i32> %val, ptr %base) {
; CHECK-LABEL: f5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vstbrf %v24, 4095(%r2)
; CHECK-NEXT:    br %r14
  %addr = getelementptr i8, ptr %base, i64 4095
  %swap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val)
  store <4 x i32> %swap, ptr %addr, align 1
  ret void
}

; Test the next offset up, which requires separate address logic,
define void @f6(<4 x i32> %val, ptr %base) {
; CHECK-LABEL: f6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    aghi %r2, 4096
; CHECK-NEXT:    vstbrf %v24, 0(%r2)
; CHECK-NEXT:    br %r14
  %ptr = getelementptr <4 x i32>, ptr %base, i64 256
  %swap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val)
  store <4 x i32> %swap, ptr %ptr
  ret void
}

; Test negative offsets, which also require separate address logic,
define void @f7(<4 x i32> %val, ptr %base) {
; CHECK-LABEL: f7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    aghi %r2, -16
; CHECK-NEXT:    vstbrf %v24, 0(%r2)
; CHECK-NEXT:    br %r14
  %ptr = getelementptr <4 x i32>, ptr %base, i64 -1
  %swap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val)
  store <4 x i32> %swap, ptr %ptr
  ret void
}

; Check that indexes are allowed.
define void @f8(<4 x i32> %val, ptr %base, i64 %index) {
; CHECK-LABEL: f8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vstbrf %v24, 0(%r3,%r2)
; CHECK-NEXT:    br %r14
  %addr = getelementptr i8, ptr %base, i64 %index
  %swap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val)
  store <4 x i32> %swap, ptr %addr, align 1
  ret void
}

