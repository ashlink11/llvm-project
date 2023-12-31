; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Check that assume is propagated backwards through all
; operations that are `isGuaranteedToTransferExecutionToSuccessor`
define i32 @assume_inevitable(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: @assume_inevitable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[M:%.*]] = alloca i64, align 8
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A:%.*]], align 4
; CHECK-NEXT:    [[LOADRES:%.*]] = load i32, ptr [[B:%.*]], align 4
; CHECK-NEXT:    [[LOADRES2:%.*]] = call i32 @llvm.annotation.i32.p0(i32 [[LOADRES]], ptr nonnull @.str, ptr nonnull @.str1, i32 2)
; CHECK-NEXT:    store i32 [[LOADRES2]], ptr [[A]], align 4
; CHECK-NEXT:    [[DUMMY_EQ:%.*]] = icmp ugt i32 [[LOADRES]], 42
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[DUMMY_EQ]])
; CHECK-NEXT:    [[M_A:%.*]] = call ptr @llvm.ptr.annotation.p0.p0(ptr nonnull [[M]], ptr nonnull @.str, ptr nonnull @.str1, i32 2, ptr null)
; CHECK-NEXT:    [[OBJSZ:%.*]] = call i64 @llvm.objectsize.i64.p0(ptr [[C:%.*]], i1 false, i1 false, i1 false)
; CHECK-NEXT:    store i64 [[OBJSZ]], ptr [[M_A]], align 4
; CHECK-NEXT:    [[PTRINT:%.*]] = ptrtoint ptr [[A]] to i64
; CHECK-NEXT:    [[MASKEDPTR:%.*]] = and i64 [[PTRINT]], 31
; CHECK-NEXT:    [[MASKCOND:%.*]] = icmp eq i64 [[MASKEDPTR]], 0
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[MASKCOND]])
; CHECK-NEXT:    ret i32 [[TMP0]]
;
entry:
  %dummy = alloca i8, align 4
  %m = alloca i64
  %0 = load i32, ptr %a, align 4

  ; START perform a bunch of inevitable operations
  %loadres = load i32, ptr %b
  %loadres2 = call i32 @llvm.annotation.i32(i32 %loadres, ptr @.str, ptr @.str1, i32 2)
  store i32 %loadres2, ptr %a

  %dummy_eq = icmp ugt i32 %loadres, 42
  tail call void @llvm.assume(i1 %dummy_eq)

  call void @llvm.lifetime.start.p0(i64 1, ptr %dummy)
  %i = call ptr @llvm.invariant.start.p0(i64 1, ptr %dummy)
  call void @llvm.invariant.end.p0(ptr %i, i64 1, ptr %dummy)
  call void @llvm.lifetime.end.p0(i64 1, ptr %dummy)

  %m_a = call ptr @llvm.ptr.annotation.p0(ptr %m, ptr @.str, ptr @.str1, i32 2, ptr null)
  %objsz = call i64 @llvm.objectsize.i64.p0(ptr %c, i1 false)
  store i64 %objsz, ptr %m_a
  ; END perform a bunch of inevitable operations

  ; AND here's the assume:
  %ptrint = ptrtoint ptr %a to i64
  %maskedptr = and i64 %ptrint, 31
  %maskcond = icmp eq i64 %maskedptr, 0
  tail call void @llvm.assume(i1 %maskcond)

  ret i32 %0
}

@.str = private unnamed_addr constant [4 x i8] c"sth\00", section "llvm.metadata"
@.str1 = private unnamed_addr constant [4 x i8] c"t.c\00", section "llvm.metadata"

declare i64 @llvm.objectsize.i64.p0(ptr, i1)
declare i32 @llvm.annotation.i32(i32, ptr, ptr, i32)
declare ptr @llvm.ptr.annotation.p0(ptr, ptr, ptr, i32, ptr)

declare void @llvm.lifetime.start.p0(i64, ptr nocapture)
declare void @llvm.lifetime.end.p0(i64, ptr nocapture)

declare ptr @llvm.invariant.start.p0(i64, ptr nocapture)
declare void @llvm.invariant.end.p0(ptr, i64, ptr nocapture)
declare void @llvm.assume(i1)
