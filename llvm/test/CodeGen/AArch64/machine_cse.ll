; RUN: llc < %s -mtriple=aarch64-linux-gnuabi -O2 -tail-dup-placement=0 | FileCheck %s
; -tail-dup-placement causes tail duplication during layout. This breaks the
; assumptions of the test case as written (specifically, it creates an
; additional cmp instruction, creating a false positive), so we pass
; -tail-dup-placement=0 to restore the original behavior

; marked as external to prevent possible optimizations
@a = external global i32
@b = external global i32
@c = external global i32
@d = external global i32
@e = external global i32

define i32 @combine-sign-comparisons-by-cse(ptr %arg) {
; CHECK: cmp
; CHECK: b.ge
; CHECK-NOT: cmp
; CHECK: b.le

entry:
  %a = load i32, ptr @a, align 4
  %b = load i32, ptr @b, align 4
  %c = load i32, ptr @c, align 4
  %d = load i32, ptr @d, align 4
  %e = load i32, ptr @e, align 4

  %cmp = icmp slt i32 %a, %e
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:
  %cmp1 = icmp eq i32 %b, %c
  br i1 %cmp1, label %return, label %if.end

lor.lhs.false:
  %cmp2 = icmp sgt i32 %a, %e
  br i1 %cmp2, label %land.lhs.true3, label %if.end

land.lhs.true3:
  %cmp4 = icmp eq i32 %b, %d
  br i1 %cmp4, label %return, label %if.end

if.end:
  br label %return

return:
  %retval.0 = phi i32 [ 0, %if.end ], [ 1, %land.lhs.true3 ], [ 1, %land.lhs.true ]
  store i32 %a, ptr %arg
  ret i32 %retval.0
}

define void @combine_vector_zeros(ptr %p, ptr %q) {
; CHECK-LABEL: combine_vector_zeros:
; CHECK: movi v[[REG:[0-9]+]].2d, #0
; CHECK-NOT: movi
; CHECK: str d[[REG]], [x0]
; CHECK: str q[[REG]], [x1]
entry:
  store <8 x i8> zeroinitializer, ptr %p
  store <16 x i8> zeroinitializer, ptr %q
  ret void
}

define void @combine_vector_ones(ptr %p, ptr %q) {
; CHECK-LABEL: combine_vector_ones:
; CHECK: movi v[[REG:[0-9]+]].2d, #0xffffffffffffffff
; CHECK-NOT: movi
; CHECK: str d[[REG]], [x0]
; CHECK: str q[[REG]], [x1]
entry:
  store <2 x i32> <i32 -1, i32 -1>, ptr %p
  store <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>, ptr %q
  ret void
}
