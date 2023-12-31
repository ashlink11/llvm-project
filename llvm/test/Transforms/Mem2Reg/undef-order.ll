; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
;RUN: opt -passes=mem2reg -S < %s | FileCheck %s

declare i1 @cond()

define i32 @foo() {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[C1:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C1]], label [[STORE1:%.*]], label [[STORE2:%.*]]
; CHECK:       Block1:
; CHECK-NEXT:    br label [[JOIN:%.*]]
; CHECK:       Block2:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block3:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block4:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block5:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Store1:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block6:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block7:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block8:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block9:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block10:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Store2:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block11:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block12:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block13:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block14:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block15:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block16:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Join:
; CHECK-NEXT:    [[VAL_0:%.*]] = phi i32 [ 1, [[STORE1]] ], [ 2, [[STORE2]] ], [ poison, [[BLOCK1:%.*]] ], [ poison, [[BLOCK2:%.*]] ], [ poison, [[BLOCK3:%.*]] ], [ poison, [[BLOCK4:%.*]] ], [ poison, [[BLOCK5:%.*]] ], [ poison, [[BLOCK6:%.*]] ], [ poison, [[BLOCK7:%.*]] ], [ poison, [[BLOCK8:%.*]] ], [ poison, [[BLOCK9:%.*]] ], [ poison, [[BLOCK10:%.*]] ], [ poison, [[BLOCK11:%.*]] ], [ poison, [[BLOCK12:%.*]] ], [ poison, [[BLOCK13:%.*]] ], [ poison, [[BLOCK14:%.*]] ], [ poison, [[BLOCK15:%.*]] ], [ poison, [[BLOCK16:%.*]] ]
; CHECK-NEXT:    ret i32 [[VAL_0]]
;
Entry:
  %val = alloca i32
  %c1 = call i1 @cond()
  br i1 %c1, label %Store1, label %Store2
Block1:
  br label %Join
Block2:
  br label %Join
Block3:
  br label %Join
Block4:
  br label %Join
Block5:
  br label %Join
Store1:
  store i32 1, ptr %val
  br label %Join
Block6:
  br label %Join
Block7:
  br label %Join
Block8:
  br label %Join
Block9:
  br label %Join
Block10:
  br label %Join
Store2:
  store i32 2, ptr %val
  br label %Join
Block11:
  br label %Join
Block12:
  br label %Join
Block13:
  br label %Join
Block14:
  br label %Join
Block15:
  br label %Join
Block16:
  br label %Join
Join:
; Phi inserted here should have operands appended deterministically
  %result = load i32, ptr %val
  ret i32 %result
}
