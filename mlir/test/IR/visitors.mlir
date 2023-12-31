// RUN: mlir-opt -test-ir-visitors -allow-unregistered-dialect -split-input-file %s | FileCheck %s

// Verify the different configurations of IR visitors.
// Constant, yield and other terminator ops are not matched for simplicity.
// Module and function op and their immediately nested blocks are not erased in
// callbacks with return so that the output includes more cases in pre-order.

func.func @structured_cfg() {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c10 = arith.constant 10 : index
  scf.for %i = %c1 to %c10 step %c1 {
    %cond = "use0"(%i) : (index) -> (i1)
    scf.if %cond {
      "use1"(%i) : (index) -> ()
    } else {
      "use2"(%i) : (index) -> ()
    }
    "use3"(%i) : (index) -> ()
  } {walk_blocks, walk_regions}
  return
}

// CHECK-LABEL: Op pre-order visit
// CHECK:       Visiting op 'builtin.module'
// CHECK:       Visiting op 'func.func'
// CHECK:       Visiting op 'scf.for'
// CHECK:       Visiting op 'use0'
// CHECK:       Visiting op 'scf.if'
// CHECK:       Visiting op 'use1'
// CHECK:       Visiting op 'use2'
// CHECK:       Visiting op 'use3'
// CHECK:       Visiting op 'func.return'

// CHECK-LABEL: Block pre-order visits
// CHECK:       Visiting block ^bb0 from region 0 from operation 'builtin.module'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.for'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.if'
// CHECK:       Visiting block ^bb0 from region 1 from operation 'scf.if'

// CHECK-LABEL: Region pre-order visits
// CHECK:       Visiting region 0 from operation 'builtin.module'
// CHECK:       Visiting region 0 from operation 'func.func'
// CHECK:       Visiting region 0 from operation 'scf.for'
// CHECK:       Visiting region 0 from operation 'scf.if'
// CHECK:       Visiting region 1 from operation 'scf.if'

// CHECK-LABEL: Op post-order visits
// CHECK:       Visiting op 'use0'
// CHECK:       Visiting op 'use1'
// CHECK:       Visiting op 'use2'
// CHECK:       Visiting op 'scf.if'
// CHECK:       Visiting op 'use3'
// CHECK:       Visiting op 'scf.for'
// CHECK:       Visiting op 'func.return'
// CHECK:       Visiting op 'func.func'
// CHECK:       Visiting op 'builtin.module'

// CHECK-LABEL: Block post-order visits
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.if'
// CHECK:       Visiting block ^bb0 from region 1 from operation 'scf.if'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.for'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'builtin.module'

// CHECK-LABEL: Region post-order visits
// CHECK:       Visiting region 0 from operation 'scf.if'
// CHECK:       Visiting region 1 from operation 'scf.if'
// CHECK:       Visiting region 0 from operation 'scf.for'
// CHECK:       Visiting region 0 from operation 'func.func'
// CHECK:       Visiting region 0 from operation 'builtin.module'

// CHECK-LABEL: Op reverse post-order visits
// CHECK:       Visiting op 'func.return'
// CHECK:       Visiting op 'scf.yield'
// CHECK:       Visiting op 'use3'
// CHECK:       Visiting op 'scf.yield'
// CHECK:       Visiting op 'use2'
// CHECK:       Visiting op 'scf.yield'
// CHECK:       Visiting op 'use1'
// CHECK:       Visiting op 'scf.if'
// CHECK:       Visiting op 'use0'
// CHECK:       Visiting op 'scf.for'
// CHECK:       Visiting op 'arith.constant'
// CHECK:       Visiting op 'arith.constant'
// CHECK:       Visiting op 'arith.constant'
// CHECK:       Visiting op 'func.func'
// CHECK:       Visiting op 'builtin.module'

// CHECK-LABEL: Invoke block pre-order visits on blocks
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.for'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.if'
// CHECK:       Visiting block ^bb0 from region 1 from operation 'scf.if'

// CHECK-LABEL: Invoke block post-order visits on blocks
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.if'
// CHECK:       Visiting block ^bb0 from region 1 from operation 'scf.if'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'scf.for'

// CHECK-LABEL: Invoke region pre-order visits on region
// CHECK:       Visiting region 0 from operation 'scf.for'
// CHECK:       Visiting region 0 from operation 'scf.if'
// CHECK:       Visiting region 1 from operation 'scf.if'

// CHECK-LABEL: Invoke region post-order visits on region
// CHECK:       Visiting region 0 from operation 'scf.if'
// CHECK:       Visiting region 1 from operation 'scf.if'
// CHECK:       Visiting region 0 from operation 'scf.for'

// CHECK-LABEL: Op pre-order erasures
// CHECK:       Erasing op 'scf.for'
// CHECK:       Erasing op 'func.return'

// CHECK-LABEL: Block pre-order erasures
// CHECK:       Erasing block ^bb0 from region 0 from operation 'scf.for'

// CHECK-LABEL: Op post-order erasures (skip)
// CHECK:       Erasing op 'use0'
// CHECK:       Erasing op 'use1'
// CHECK:       Erasing op 'use2'
// CHECK:       Erasing op 'scf.if'
// CHECK:       Erasing op 'use3'
// CHECK:       Erasing op 'scf.for'
// CHECK:       Erasing op 'func.return'

// CHECK-LABEL: Block post-order erasures (skip)
// CHECK:       Erasing block ^bb0 from region 0 from operation 'scf.if'
// CHECK:       Erasing block ^bb0 from region 1 from operation 'scf.if'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'scf.for'

// CHECK-LABEL: Op post-order erasures (no skip)
// CHECK:       Erasing op 'use0'
// CHECK:       Erasing op 'use1'
// CHECK:       Erasing op 'use2'
// CHECK:       Erasing op 'scf.if'
// CHECK:       Erasing op 'use3'
// CHECK:       Erasing op 'scf.for'
// CHECK:       Erasing op 'func.return'
// CHECK:       Erasing op 'func.func'
// CHECK:       Erasing op 'builtin.module'

// CHECK-LABEL: Block post-order erasures (no skip)
// CHECK:       Erasing block ^bb0 from region 0 from operation 'scf.if'
// CHECK:       Erasing block ^bb0 from region 1 from operation 'scf.if'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'scf.for'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'builtin.module'

// -----

func.func @unstructured_cfg() {
  "regionOp0"() ({
    ^bb0:
      "op0"() : () -> ()
      cf.br ^bb2
    ^bb1:
      "op1"() : () -> ()
      cf.br ^bb2
    ^bb2:
      "op2"() : () -> ()
  }) : () -> ()
  return
}

// CHECK-LABEL: Op pre-order visits
// CHECK:       Visiting op 'builtin.module'
// CHECK:       Visiting op 'func.func'
// CHECK:       Visiting op 'regionOp0'
// CHECK:       Visiting op 'op0'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op1'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op2'
// CHECK:       Visiting op 'func.return'

// CHECK-LABEL: Block pre-order visits
// CHECK:       Visiting block ^bb0 from region 0 from operation 'builtin.module'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb1 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb2 from region 0 from operation 'regionOp0'

// CHECK-LABEL: Region pre-order visits
// CHECK:       Visiting region 0 from operation 'builtin.module'
// CHECK:       Visiting region 0 from operation 'func.func'
// CHECK:       Visiting region 0 from operation 'regionOp0'

// CHECK-LABEL: Op post-order visits
// CHECK:       Visiting op 'op0'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op1'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op2'
// CHECK:       Visiting op 'regionOp0'
// CHECK:       Visiting op 'func.return'
// CHECK:       Visiting op 'func.func'
// CHECK:       Visiting op 'builtin.module'

// CHECK-LABEL: Block post-order visits
// CHECK:       Visiting block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb1 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb2 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'builtin.module'

// CHECK-LABEL: Region post-order visits
// CHECK:       Visiting region 0 from operation 'regionOp0'
// CHECK:       Visiting region 0 from operation 'func.func'
// CHECK:       Visiting region 0 from operation 'builtin.module'

// CHECK-LABEL: Op reverse post-order visits
// CHECK:       Visiting op 'func.return'
// CHECK:       Visiting op 'op2'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op1'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op0'
// CHECK:       Visiting op 'regionOp0'
// CHECK:       Visiting op 'func.func'
// CHECK:       Visiting op 'builtin.module'

// CHECK-LABEL: Block reverse post-order visits
// CHECK:       Visiting block ^bb2 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb1 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'builtin.module'

// CHECK-LABEL: Region reverse post-order visits
// CHECK:       Visiting region 0 from operation 'regionOp0'
// CHECK:       Visiting region 0 from operation 'func.func'
// CHECK:       Visiting region 0 from operation 'builtin.module'

// CHECK-LABEL: Op pre-order erasures (skip)
// CHECK:       Erasing op 'regionOp0'
// CHECK:       Erasing op 'func.return'

// CHECK-LABEL: Block pre-order erasures (skip)
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'

// CHECK-LABEL: Op post-order erasures (skip)
// CHECK:       Erasing op 'op0'
// CHECK:       Erasing op 'cf.br'
// CHECK:       Erasing op 'op1'
// CHECK:       Erasing op 'cf.br'
// CHECK:       Erasing op 'op2'
// CHECK:       Erasing op 'regionOp0'
// CHECK:       Erasing op 'func.return'

// CHECK-LABEL: Block post-order erasures (skip)
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'

// CHECK-LABEL: Op post-order erasures (no skip)
// CHECK:       Erasing op 'op0'
// CHECK:       Erasing op 'cf.br'
// CHECK:       Erasing op 'op1'
// CHECK:       Erasing op 'cf.br'
// CHECK:       Erasing op 'op2'
// CHECK:       Erasing op 'regionOp0'
// CHECK:       Erasing op 'func.return'

// CHECK-LABEL: Block post-order erasures (no skip)
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'func.func'
// CHECK:       Erasing block ^bb0 from region 0 from operation 'builtin.module'

// -----

func.func @unordered_cfg_with_loop() {
  "regionOp0"() ({
    ^bb0:
      %c = "op0"() : () -> (i1)
      cf.cond_br %c, ^bb2, ^bb3
    ^bb1:
      "op1"(%val) : (i32) -> ()
      cf.br ^bb5
    ^bb2:
      %val = "op2"() : () -> (i32)
      cf.br ^bb1
    ^bb3:
      "op3"() : () -> ()
      cf.br ^bb2
    ^bb4:
      "op4"() : () -> ()
      cf.br ^bb2
    ^bb5:
      "op5"() : () -> ()
      cf.br ^bb7
    ^bb6:
      "op6"() : () -> ()
      cf.br ^bb6
    ^bb7:
      "op7"() : () -> ()
  }) : () -> ()
  return
}

//      4
//      |
//      v
// 0 -> 2 --> 1 --> 5 --> 7
// |    ^
// |    |      6 --
// |   /       ^   \
// |  /         \  /
// v /           --
//  3

// CHECK-LABEL: Op forward dominance post-order visits
// CHECK:       Visiting op 'op0'
// CHECK:       Visiting op 'cf.cond_br'
// CHECK:       Visiting op 'op2'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op1'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op5'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op7'
// CHECK:       Visiting op 'op3'
// CHECK:       Visiting op 'cf.br'
// CHECK-NOT:   Visiting op 'op6'
// CHECK:       Visiting op 'regionOp0'
// CHECK:       Visiting op 'func.return'
// CHECK:       Visiting op 'func.func'

// CHECK-LABEL: Block forward dominance post-order visits
// CHECK:       Visiting block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb2 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb1 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb5 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb7 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb3 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'

// CHECK-LABEL: Region forward dominance post-order visits
// CHECK:       Visiting region 0 from operation 'regionOp0'
// CHECK:       Visiting region 0 from operation 'func.func'

// CHECK-LABEL: Op reverse dominance post-order visits
// CHECK:       Visiting op 'func.return'
// CHECK-NOT:   Visiting op 'op6'
// CHECK:       Visiting op 'op7'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op5'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op1'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op2'
// CHECK:       Visiting op 'cf.br'
// CHECK:       Visiting op 'op3'
// CHECK:       Visiting op 'cf.cond_br'
// CHECK:       Visiting op 'op0'
// CHECK:       Visiting op 'regionOp0'
// CHECK:       Visiting op 'func.func'

// CHECK-LABEL: Block reverse dominance post-order visits
// CHECK:       Visiting block ^bb7 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb5 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb1 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb2 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb3 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Visiting block ^bb0 from region 0 from operation 'func.func'

// CHECK-LABEL: Region reverse dominance post-order visits
// CHECK:       Visiting region 0 from operation 'regionOp0'
// CHECK:       Visiting region 0 from operation 'func.func'

// CHECK-LABEL: Block pre-order erasures (skip)
// CHECK:       Erasing block ^bb0 from region 0 from operation 'regionOp0'
// CHECK:       Cannot erase block ^bb0 from region 0 from operation 'regionOp0', still has uses
// CHECK:       Cannot erase block ^bb1 from region 0 from operation 'regionOp0', still has uses
// CHECK:       Erasing block ^bb2 from region 0 from operation 'regionOp0'
// CHECK:       Erasing block ^bb2 from region 0 from operation 'regionOp0'
// CHECK:       Cannot erase block ^bb2 from region 0 from operation 'regionOp0', still has uses
// CHECK:       Cannot erase block ^bb3 from region 0 from operation 'regionOp0', still has uses
// CHECK:       Cannot erase block ^bb4 from region 0 from operation 'regionOp0', still has uses
