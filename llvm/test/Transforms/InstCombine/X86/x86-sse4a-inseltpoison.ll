; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -mtriple=x86_64-unknown-unknown -S | FileCheck %s

;
; EXTRQ
;

define <2 x i64> @test_extrq_call(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_call(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> [[X:%.*]], <16 x i8> [[Y:%.*]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> %y) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_extrq_zero_arg0(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_zero_arg0(
; CHECK-NEXT:    ret <2 x i64> <i64 0, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> zeroinitializer, <16 x i8> %y) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_extrq_zero_arg1(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_zero_arg1(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[X:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i8> [[TMP1]], <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP2]] to <2 x i64>
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> zeroinitializer) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_extrq_to_extqi(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_to_extqi(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> [[X:%.*]], i8 8, i8 15)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> <i8 8, i8 15, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0>) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_extrq_constant(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_constant(
; CHECK-NEXT:    ret <2 x i64> <i64 255, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> <i64 -1, i64 55>, <16 x i8> <i8 8, i8 15, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0>) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_extrq_constant_poison(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_constant_poison(
; CHECK-NEXT:    ret <2 x i64> <i64 65535, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> <i64 -1, i64 poison>, <16 x i8> <i8 16, i8 15, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0>) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_extrq_call_constexpr(<2 x i64> %x) {
; CHECK-LABEL: @test_extrq_call_constexpr(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[X:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i8> [[TMP1]], <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP2]] to <2 x i64>
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %1 = call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> bitcast (<2 x i64> <i64 0, i64 poison> to <16 x i8>))
  ret <2 x i64> %1
}

;
; EXTRQI
;

define <2 x i64> @test_extrqi_call(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_call(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> [[X:%.*]], i8 8, i8 23)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %x, i8 8, i8 23)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_shuffle_1zuu(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_shuffle_1zuu(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[X:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i8> [[TMP1]], <16 x i8> <i8 poison, i8 poison, i8 poison, i8 poison, i8 0, i8 0, i8 0, i8 0, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison>, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 20, i32 21, i32 22, i32 23, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP2]] to <2 x i64>
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %x, i8 32, i8 32)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_shuffle_2zzzzzzzuuuuuuuu(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_shuffle_2zzzzzzzuuuuuuuu(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[X:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i8> [[TMP1]], <16 x i8> <i8 poison, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison>, <16 x i32> <i32 2, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP2]] to <2 x i64>
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %x, i8 8, i8 16)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_poison(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_poison(
; CHECK-NEXT:    ret <2 x i64> undef
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> zeroinitializer, i8 32, i8 33)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_zero(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_zero(
; CHECK-NEXT:    ret <2 x i64> <i64 0, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> zeroinitializer, i8 3, i8 18)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_constant(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_constant(
; CHECK-NEXT:    ret <2 x i64> <i64 7, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> <i64 -1, i64 55>, i8 3, i8 18)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_constant_poison(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_constant_poison(
; CHECK-NEXT:    ret <2 x i64> <i64 15, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> <i64 -1, i64 poison>, i8 4, i8 18)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_call_constexpr() {
; CHECK-LABEL: @test_extrqi_call_constexpr(
; CHECK-NEXT:    ret <2 x i64> zeroinitializer
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> bitcast (<16 x i8> trunc (<16 x i16> bitcast (<4 x i64> <i64 0, i64 poison, i64 2, i64 poison> to <16 x i16>) to <16 x i8>) to <2 x i64>), i8 8, i8 16)
  ret <2 x i64> %1
}

;
; INSERTQ
;

define <2 x i64> @test_insertq_call(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertq_call(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> [[X:%.*]], <2 x i64> [[Y:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %x, <2 x i64> %y) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_insertq_to_insertqi(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertq_to_insertqi(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> [[X:%.*]], <2 x i64> <i64 8, i64 poison>, i8 18, i8 2)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %x, <2 x i64> <i64 8, i64 658>) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_insertq_constant(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertq_constant(
; CHECK-NEXT:    ret <2 x i64> <i64 32, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> <i64 0, i64 0>, <2 x i64> <i64 8, i64 658>) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_insertq_constant_poison(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertq_constant_poison(
; CHECK-NEXT:    ret <2 x i64> <i64 33, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> <i64 1, i64 poison>, <2 x i64> <i64 8, i64 658>) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_insertq_call_constexpr(<2 x i64> %x) {
; CHECK-LABEL: @test_insertq_call_constexpr(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> [[X:%.*]], <2 x i64> <i64 0, i64 poison>, i8 2, i8 0)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %x, <2 x i64> bitcast (<16 x i8> trunc (<16 x i16> bitcast (<4 x i64> <i64 0, i64 poison, i64 2, i64 poison> to <16 x i16>) to <16 x i8>) to <2 x i64>))
  ret <2 x i64> %1
}

;
; INSERTQI
;

define <16 x i8> @test_insertqi_shuffle_04uu(<16 x i8> %v, <16 x i8> %i) {
; CHECK-LABEL: @test_insertqi_shuffle_04uu(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i8> [[V:%.*]], <16 x i8> [[I:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 16, i32 17, i32 18, i32 19, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    ret <16 x i8> [[TMP1]]
;
  %1 = bitcast <16 x i8> %v to <2 x i64>
  %2 = bitcast <16 x i8> %i to <2 x i64>
  %3 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %1, <2 x i64> %2, i8 32, i8 32)
  %4 = bitcast <2 x i64> %3 to <16 x i8>
  ret <16 x i8> %4
}

define <16 x i8> @test_insertqi_shuffle_8123uuuu(<16 x i8> %v, <16 x i8> %i) {
; CHECK-LABEL: @test_insertqi_shuffle_8123uuuu(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i8> [[I:%.*]], <16 x i8> [[V:%.*]], <16 x i32> <i32 0, i32 1, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    ret <16 x i8> [[TMP1]]
;
  %1 = bitcast <16 x i8> %v to <2 x i64>
  %2 = bitcast <16 x i8> %i to <2 x i64>
  %3 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %1, <2 x i64> %2, i8 16, i8 0)
  %4 = bitcast <2 x i64> %3 to <16 x i8>
  ret <16 x i8> %4
}

define <2 x i64> @test_insertqi_constant(<2 x i64> %v, <2 x i64> %i) {
; CHECK-LABEL: @test_insertqi_constant(
; CHECK-NEXT:    ret <2 x i64> <i64 -131055, i64 undef>
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> <i64 -1, i64 -1>, <2 x i64> <i64 8, i64 0>, i8 16, i8 1)
  ret <2 x i64> %1
}

define <2 x i64> @test_insertqi_call_constexpr(<2 x i64> %x) {
; CHECK-LABEL: @test_insertqi_call_constexpr(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> [[X:%.*]], <2 x i64> <i64 0, i64 poison>, i8 48, i8 3)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %x, <2 x i64> bitcast (<16 x i8> trunc (<16 x i16> bitcast (<4 x i64> <i64 0, i64 poison, i64 2, i64 poison> to <16 x i16>) to <16 x i8>) to <2 x i64>), i8 48, i8 3)
  ret <2 x i64> %1
}

; The result of this insert is the second arg, since the top 64 bits of
; the result are poisonined, and we copy the bottom 64 bits from the
; second arg
define <2 x i64> @testInsert64Bits(<2 x i64> %v, <2 x i64> %i) {
; CHECK-LABEL: @testInsert64Bits(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[I:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i8> [[TMP1]], <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP2]] to <2 x i64>
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %v, <2 x i64> %i, i8 64, i8 0)
  ret <2 x i64> %1
}

define <2 x i64> @testZeroLength(<2 x i64> %v, <2 x i64> %i) {
; CHECK-LABEL: @testZeroLength(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[I:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i8> [[TMP1]], <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP2]] to <2 x i64>
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %v, <2 x i64> %i, i8 0, i8 0)
  ret <2 x i64> %1
}

define <2 x i64> @testUndefinedInsertq_1(<2 x i64> %v, <2 x i64> %i) {
; CHECK-LABEL: @testUndefinedInsertq_1(
; CHECK-NEXT:    ret <2 x i64> undef
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %v, <2 x i64> %i, i8 0, i8 16)
  ret <2 x i64> %1
}

define <2 x i64> @testUndefinedInsertq_2(<2 x i64> %v, <2 x i64> %i) {
; CHECK-LABEL: @testUndefinedInsertq_2(
; CHECK-NEXT:    ret <2 x i64> undef
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %v, <2 x i64> %i, i8 48, i8 32)
  ret <2 x i64> %1
}

define <2 x i64> @testUndefinedInsertq_3(<2 x i64> %v, <2 x i64> %i) {
; CHECK-LABEL: @testUndefinedInsertq_3(
; CHECK-NEXT:    ret <2 x i64> undef
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %v, <2 x i64> %i, i8 64, i8 16)
  ret <2 x i64> %1
}

;
; Vector Demanded Bits
;

define <2 x i64> @test_extrq_arg0(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_arg0(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> [[X:%.*]], <16 x i8> [[Y:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %x, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %1, <16 x i8> %y) nounwind
  ret <2 x i64> %2
}

define <2 x i64> @test_extrq_arg1(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_arg1(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> [[X:%.*]], <16 x i8> [[Y:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <16 x i8> %y, <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> %1) nounwind
  ret <2 x i64> %2
}

define <2 x i64> @test_extrq_args01(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_args01(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> [[X:%.*]], <16 x i8> [[Y:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %x, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = shufflevector <16 x i8> %y, <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %3 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %1, <16 x i8> %2) nounwind
  ret <2 x i64> %3
}

define <2 x i64> @test_extrq_ret(<2 x i64> %x, <16 x i8> %y) {
; CHECK-LABEL: @test_extrq_ret(
; CHECK-NEXT:    ret <2 x i64> poison
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> %y) nounwind
  %2 = shufflevector <2 x i64> %1, <2 x i64> poison, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %2
}

define <2 x i64> @test_extrqi_arg0(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_arg0(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> [[X:%.*]], i8 3, i8 2)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %x, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %1, i8 3, i8 2)
  ret <2 x i64> %2
}

define <2 x i64> @test_extrqi_ret(<2 x i64> %x) {
; CHECK-LABEL: @test_extrqi_ret(
; CHECK-NEXT:    ret <2 x i64> poison
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %x, i8 3, i8 2) nounwind
  %2 = shufflevector <2 x i64> %1, <2 x i64> poison, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %2
}

define <2 x i64> @test_insertq_arg0(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertq_arg0(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> [[X:%.*]], <2 x i64> [[Y:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %x, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %1, <2 x i64> %y) nounwind
  ret <2 x i64> %2
}

define <2 x i64> @test_insertq_ret(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertq_ret(
; CHECK-NEXT:    ret <2 x i64> poison
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %x, <2 x i64> %y) nounwind
  %2 = shufflevector <2 x i64> %1, <2 x i64> poison, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %2
}

define <2 x i64> @test_insertqi_arg0(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertqi_arg0(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> [[X:%.*]], <2 x i64> [[Y:%.*]], i8 3, i8 2) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %x, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %1, <2 x i64> %y, i8 3, i8 2) nounwind
  ret <2 x i64> %2
}

define <2 x i64> @test_insertqi_arg1(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertqi_arg1(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> [[X:%.*]], <2 x i64> [[Y:%.*]], i8 3, i8 2) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %y, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %x, <2 x i64> %1, i8 3, i8 2) nounwind
  ret <2 x i64> %2
}

define <2 x i64> @test_insertqi_args01(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertqi_args01(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> [[X:%.*]], <2 x i64> [[Y:%.*]], i8 3, i8 2) #[[ATTR1]]
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = shufflevector <2 x i64> %x, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %2 = shufflevector <2 x i64> %y, <2 x i64> poison, <2 x i32> <i32 0, i32 0>
  %3 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %1, <2 x i64> %2, i8 3, i8 2) nounwind
  ret <2 x i64> %3
}

define <2 x i64> @test_insertqi_ret(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: @test_insertqi_ret(
; CHECK-NEXT:    ret <2 x i64> poison
;
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %x, <2 x i64> %y, i8 3, i8 2) nounwind
  %2 = shufflevector <2 x i64> %1, <2 x i64> poison, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %2
}

declare <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64>, <16 x i8>) nounwind

declare <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64>, i8, i8) nounwind

declare <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64>, <2 x i64>) nounwind

declare <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64>, <2 x i64>, i8, i8) nounwind
