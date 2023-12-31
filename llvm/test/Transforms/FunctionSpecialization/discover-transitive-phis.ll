; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
;
; RUN: opt -passes="ipsccp<func-spec>" -funcspec-min-function-size=20 -funcspec-for-literal-constant -S < %s | FileCheck %s --check-prefix=FUNCSPEC
; RUN: opt -passes="ipsccp<func-spec>" -funcspec-min-function-size=20 -funcspec-for-literal-constant -funcspec-max-discovery-iterations=16 -S < %s | FileCheck %s --check-prefix=NOFUNCSPEC

define i64 @bar(i1 %c1, i1 %c2, i1 %c3, i1 %c4, i1 %c5, i1 %c6, i1 %c7, i1 %c8, i1 %c9, i1 %c10) {
; FUNCSPEC-LABEL: define i64 @bar(
; FUNCSPEC-SAME: i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]], i1 [[C4:%.*]], i1 [[C5:%.*]], i1 [[C6:%.*]], i1 [[C7:%.*]], i1 [[C8:%.*]], i1 [[C9:%.*]], i1 [[C10:%.*]]) {
; FUNCSPEC-NEXT:  entry:
; FUNCSPEC-NEXT:    [[F1:%.*]] = call i64 @foo.specialized.1(i64 3, i1 [[C1]], i1 [[C2]], i1 [[C3]], i1 [[C4]], i1 [[C5]], i1 [[C6]], i1 [[C7]], i1 [[C8]], i1 [[C9]], i1 [[C10]]), !range [[RNG0:![0-9]+]]
; FUNCSPEC-NEXT:    [[F2:%.*]] = call i64 @foo.specialized.2(i64 4, i1 [[C1]], i1 [[C2]], i1 [[C3]], i1 [[C4]], i1 [[C5]], i1 [[C6]], i1 [[C7]], i1 [[C8]], i1 [[C9]], i1 [[C10]]), !range [[RNG1:![0-9]+]]
; FUNCSPEC-NEXT:    [[ADD:%.*]] = add nuw nsw i64 [[F1]], [[F2]]
; FUNCSPEC-NEXT:    ret i64 [[ADD]]
;
; NOFUNCSPEC-LABEL: define i64 @bar(
; NOFUNCSPEC-SAME: i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]], i1 [[C4:%.*]], i1 [[C5:%.*]], i1 [[C6:%.*]], i1 [[C7:%.*]], i1 [[C8:%.*]], i1 [[C9:%.*]], i1 [[C10:%.*]]) {
; NOFUNCSPEC-NEXT:  entry:
; NOFUNCSPEC-NEXT:    [[F1:%.*]] = call i64 @foo(i64 3, i1 [[C1]], i1 [[C2]], i1 [[C3]], i1 [[C4]], i1 [[C5]], i1 [[C6]], i1 [[C7]], i1 [[C8]], i1 [[C9]], i1 [[C10]]), !range [[RNG0:![0-9]+]]
; NOFUNCSPEC-NEXT:    [[F2:%.*]] = call i64 @foo(i64 4, i1 [[C1]], i1 [[C2]], i1 [[C3]], i1 [[C4]], i1 [[C5]], i1 [[C6]], i1 [[C7]], i1 [[C8]], i1 [[C9]], i1 [[C10]]), !range [[RNG0]]
; NOFUNCSPEC-NEXT:    [[ADD:%.*]] = add nuw nsw i64 [[F1]], [[F2]]
; NOFUNCSPEC-NEXT:    ret i64 [[ADD]]
;
entry:
  %f1 = call i64 @foo(i64 3, i1 %c1, i1 %c2, i1 %c3, i1 %c4, i1 %c5, i1 %c6, i1 %c7, i1 %c8, i1 %c9, i1 %c10)
  %f2 = call i64 @foo(i64 4, i1 %c1, i1 %c2, i1 %c3, i1 %c4, i1 %c5, i1 %c6, i1 %c7, i1 %c8, i1 %c9, i1 %c10)
  %add = add i64 %f1, %f2
  ret i64 %add
}

define internal i64 @foo(i64 %n, i1 %c1, i1 %c2, i1 %c3, i1 %c4, i1 %c5, i1 %c6, i1 %c7, i1 %c8, i1 %c9, i1 %c10) {
entry:
  br i1 %c1, label %l1, label %l9

l1:
  %phi1 = phi i64 [ %n, %entry ], [ %phi2, %l2 ]
  %add = add i64 %phi1, 1
  %div = sdiv i64 %add, 2
  br i1 %c2, label %l1_5, label %exit

l1_5:
  br i1 %c3, label %l1_75, label %l6

l1_75:
  br i1 %c4, label %l2, label %l3

l2:
  %phi2 = phi i64 [ %phi1, %l1_75 ], [ %phi3, %l3 ]
  br label %l1

l3:
  %phi3 = phi i64 [ %phi1, %l1_75 ], [ %phi4, %l4 ]
  br label %l2

l4:
  %phi4 = phi i64 [ %phi5, %l5 ], [ %phi6, %l6 ]
  br i1 %c5, label %l3, label %l6

l5:
  %phi5 = phi i64 [ %phi6, %l6_5 ], [ %phi7, %l7 ]
  br label %l4

l6:
  %phi6 = phi i64 [ %phi4, %l4 ], [ %phi1, %l1_5 ]
  br i1 %c6, label %l4, label %l6_5

l6_5:
  br i1 %c7, label %l5, label %l8

l7:
  %phi7 = phi i64 [ %phi9, %l9 ], [ %phi8, %l8 ]
  br i1 %c8, label %l5, label %l8

l8:
  %phi8 = phi i64 [ %phi6, %l6_5 ], [ %phi7, %l7 ]
  br i1 %c9, label %l7, label %l9

l9:
  %phi9 = phi i64 [ %n, %entry ], [ %phi8, %l8 ]
  %sub = sub i64 %phi9, 1
  %mul = mul i64 %sub, 2
  br i1 %c10, label %l7, label %exit

exit:
  %res = phi i64 [ %div, %l1 ], [ %mul, %l9]
  ret i64 %res
}

