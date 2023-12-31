; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=riscv32 -global-isel -code-model=small \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefix=RV32-SMALL
; RUN: llc < %s -mtriple=riscv32 -global-isel -code-model=medium \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefix=RV32-MEDIUM
; RUN: llc < %s -mtriple=riscv32 -global-isel -relocation-model=pic \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefix=RV32-PIC
; RUN: llc < %s -mtriple=riscv64 -global-isel -code-model=small \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefix=RV64-SMALL
; RUN: llc < %s -mtriple=riscv64 -global-isel -code-model=medium \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefix=RV64-MEDIUM
; RUN: llc < %s -mtriple=riscv64 -global-isel -relocation-model=pic \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefix=RV64-PIC

define void @constpool_f32(ptr %p) {
; RV32-SMALL-LABEL: constpool_f32:
; RV32-SMALL:       # %bb.0:
; RV32-SMALL-NEXT:    lui a1, %hi(.LCPI0_0)
; RV32-SMALL-NEXT:    lw a1, %lo(.LCPI0_0)(a1)
; RV32-SMALL-NEXT:    sw a1, 0(a0)
; RV32-SMALL-NEXT:    ret
;
; RV32-MEDIUM-LABEL: constpool_f32:
; RV32-MEDIUM:       # %bb.0:
; RV32-MEDIUM-NEXT:  .Lpcrel_hi0:
; RV32-MEDIUM-NEXT:    auipc a1, %pcrel_hi(.LCPI0_0)
; RV32-MEDIUM-NEXT:    lw a1, %pcrel_lo(.Lpcrel_hi0)(a1)
; RV32-MEDIUM-NEXT:    sw a1, 0(a0)
; RV32-MEDIUM-NEXT:    ret
;
; RV32-PIC-LABEL: constpool_f32:
; RV32-PIC:       # %bb.0:
; RV32-PIC-NEXT:  .Lpcrel_hi0:
; RV32-PIC-NEXT:    auipc a1, %pcrel_hi(.LCPI0_0)
; RV32-PIC-NEXT:    lw a1, %pcrel_lo(.Lpcrel_hi0)(a1)
; RV32-PIC-NEXT:    sw a1, 0(a0)
; RV32-PIC-NEXT:    ret
;
; RV64-SMALL-LABEL: constpool_f32:
; RV64-SMALL:       # %bb.0:
; RV64-SMALL-NEXT:    lui a1, %hi(.LCPI0_0)
; RV64-SMALL-NEXT:    lw a1, %lo(.LCPI0_0)(a1)
; RV64-SMALL-NEXT:    sw a1, 0(a0)
; RV64-SMALL-NEXT:    ret
;
; RV64-MEDIUM-LABEL: constpool_f32:
; RV64-MEDIUM:       # %bb.0:
; RV64-MEDIUM-NEXT:  .Lpcrel_hi0:
; RV64-MEDIUM-NEXT:    auipc a1, %pcrel_hi(.LCPI0_0)
; RV64-MEDIUM-NEXT:    lw a1, %pcrel_lo(.Lpcrel_hi0)(a1)
; RV64-MEDIUM-NEXT:    sw a1, 0(a0)
; RV64-MEDIUM-NEXT:    ret
;
; RV64-PIC-LABEL: constpool_f32:
; RV64-PIC:       # %bb.0:
; RV64-PIC-NEXT:  .Lpcrel_hi0:
; RV64-PIC-NEXT:    auipc a1, %pcrel_hi(.LCPI0_0)
; RV64-PIC-NEXT:    lw a1, %pcrel_lo(.Lpcrel_hi0)(a1)
; RV64-PIC-NEXT:    sw a1, 0(a0)
; RV64-PIC-NEXT:    ret
  store float 1.0, ptr %p
  ret void
}

define void @constpool_f64(ptr %p) {
; RV32-SMALL-LABEL: constpool_f64:
; RV32-SMALL:       # %bb.0:
; RV32-SMALL-NEXT:    lui a1, %hi(.LCPI1_0)
; RV32-SMALL-NEXT:    addi a1, a1, %lo(.LCPI1_0)
; RV32-SMALL-NEXT:    lw a2, 0(a1)
; RV32-SMALL-NEXT:    lw a1, 4(a1)
; RV32-SMALL-NEXT:    sw a2, 0(a0)
; RV32-SMALL-NEXT:    sw a1, 4(a0)
; RV32-SMALL-NEXT:    ret
;
; RV32-MEDIUM-LABEL: constpool_f64:
; RV32-MEDIUM:       # %bb.0:
; RV32-MEDIUM-NEXT:  .Lpcrel_hi1:
; RV32-MEDIUM-NEXT:    auipc a1, %pcrel_hi(.LCPI1_0)
; RV32-MEDIUM-NEXT:    addi a1, a1, %pcrel_lo(.Lpcrel_hi1)
; RV32-MEDIUM-NEXT:    lw a2, 0(a1)
; RV32-MEDIUM-NEXT:    lw a1, 4(a1)
; RV32-MEDIUM-NEXT:    sw a2, 0(a0)
; RV32-MEDIUM-NEXT:    sw a1, 4(a0)
; RV32-MEDIUM-NEXT:    ret
;
; RV32-PIC-LABEL: constpool_f64:
; RV32-PIC:       # %bb.0:
; RV32-PIC-NEXT:  .Lpcrel_hi1:
; RV32-PIC-NEXT:    auipc a1, %pcrel_hi(.LCPI1_0)
; RV32-PIC-NEXT:    addi a1, a1, %pcrel_lo(.Lpcrel_hi1)
; RV32-PIC-NEXT:    lw a2, 0(a1)
; RV32-PIC-NEXT:    lw a1, 4(a1)
; RV32-PIC-NEXT:    sw a2, 0(a0)
; RV32-PIC-NEXT:    sw a1, 4(a0)
; RV32-PIC-NEXT:    ret
;
; RV64-SMALL-LABEL: constpool_f64:
; RV64-SMALL:       # %bb.0:
; RV64-SMALL-NEXT:    lui a1, %hi(.LCPI1_0)
; RV64-SMALL-NEXT:    ld a1, %lo(.LCPI1_0)(a1)
; RV64-SMALL-NEXT:    sd a1, 0(a0)
; RV64-SMALL-NEXT:    ret
;
; RV64-MEDIUM-LABEL: constpool_f64:
; RV64-MEDIUM:       # %bb.0:
; RV64-MEDIUM-NEXT:  .Lpcrel_hi1:
; RV64-MEDIUM-NEXT:    auipc a1, %pcrel_hi(.LCPI1_0)
; RV64-MEDIUM-NEXT:    ld a1, %pcrel_lo(.Lpcrel_hi1)(a1)
; RV64-MEDIUM-NEXT:    sd a1, 0(a0)
; RV64-MEDIUM-NEXT:    ret
;
; RV64-PIC-LABEL: constpool_f64:
; RV64-PIC:       # %bb.0:
; RV64-PIC-NEXT:  .Lpcrel_hi1:
; RV64-PIC-NEXT:    auipc a1, %pcrel_hi(.LCPI1_0)
; RV64-PIC-NEXT:    ld a1, %pcrel_lo(.Lpcrel_hi1)(a1)
; RV64-PIC-NEXT:    sd a1, 0(a0)
; RV64-PIC-NEXT:    ret
  store double 1.0, ptr %p
  ret void
}
