; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp,+fp64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-FP
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve,+fullfp16,+fp64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-NOFP

define arm_aapcs_vfpcc float @fadd_v2f32(<2 x float> %x, float %y) {
; CHECK-LABEL: fadd_v2f32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f32 s0, s0, s1
; CHECK-NEXT:    vadd.f32 s0, s4, s0
; CHECK-NEXT:    bx lr
entry:
  %z = call fast float @llvm.experimental.vector.reduce.v2.fadd.f32.v2f32(float %y, <2 x float> %x)
  ret float %z
}

define arm_aapcs_vfpcc float @fadd_v4f32(<4 x float> %x, float %y) {
; CHECK-FP-LABEL: fadd_v4f32:
; CHECK-FP:       @ %bb.0: @ %entry
; CHECK-FP-NEXT:    vadd.f32 s6, s2, s3
; CHECK-FP-NEXT:    vadd.f32 s0, s0, s1
; CHECK-FP-NEXT:    vadd.f32 s0, s0, s6
; CHECK-FP-NEXT:    vadd.f32 s0, s4, s0
; CHECK-FP-NEXT:    bx lr
;
; CHECK-NOFP-LABEL: fadd_v4f32:
; CHECK-NOFP:       @ %bb.0: @ %entry
; CHECK-NOFP-NEXT:    vadd.f32 s6, s0, s1
; CHECK-NOFP-NEXT:    vadd.f32 s6, s6, s2
; CHECK-NOFP-NEXT:    vadd.f32 s0, s6, s3
; CHECK-NOFP-NEXT:    vadd.f32 s0, s4, s0
; CHECK-NOFP-NEXT:    bx lr
entry:
  %z = call fast float @llvm.experimental.vector.reduce.v2.fadd.f32.v4f32(float %y, <4 x float> %x)
  ret float %z
}

define arm_aapcs_vfpcc float @fadd_v8f32(<8 x float> %x, float %y) {
; CHECK-FP-LABEL: fadd_v8f32:
; CHECK-FP:       @ %bb.0: @ %entry
; CHECK-FP-NEXT:    vadd.f32 q0, q0, q1
; CHECK-FP-NEXT:    vadd.f32 s4, s2, s3
; CHECK-FP-NEXT:    vadd.f32 s0, s0, s1
; CHECK-FP-NEXT:    vadd.f32 s0, s0, s4
; CHECK-FP-NEXT:    vadd.f32 s0, s8, s0
; CHECK-FP-NEXT:    bx lr
;
; CHECK-NOFP-LABEL: fadd_v8f32:
; CHECK-NOFP:       @ %bb.0: @ %entry
; CHECK-NOFP-NEXT:    vadd.f32 s12, s0, s4
; CHECK-NOFP-NEXT:    vadd.f32 s10, s1, s5
; CHECK-NOFP-NEXT:    vadd.f32 s14, s2, s6
; CHECK-NOFP-NEXT:    vadd.f32 s0, s3, s7
; CHECK-NOFP-NEXT:    vadd.f32 s10, s12, s10
; CHECK-NOFP-NEXT:    vadd.f32 s2, s10, s14
; CHECK-NOFP-NEXT:    vadd.f32 s0, s2, s0
; CHECK-NOFP-NEXT:    vadd.f32 s0, s8, s0
; CHECK-NOFP-NEXT:    bx lr
entry:
  %z = call fast float @llvm.experimental.vector.reduce.v2.fadd.f32.v8f32(float %y, <8 x float> %x)
  ret float %z
}

define arm_aapcs_vfpcc void @fadd_v2f16(<2 x half> %x, half* %yy) {
; CHECK-LABEL: fadd_v2f16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovx.f16 s4, s0
; CHECK-NEXT:    vadd.f16 s0, s0, s4
; CHECK-NEXT:    vldr.16 s2, [r0]
; CHECK-NEXT:    vadd.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call fast half @llvm.experimental.vector.reduce.v2.fadd.f16.v2f16(half %y, <2 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc void @fadd_v4f16(<4 x half> %x, half* %yy) {
; CHECK-FP-LABEL: fadd_v4f16:
; CHECK-FP:       @ %bb.0: @ %entry
; CHECK-FP-NEXT:    vmovx.f16 s4, s1
; CHECK-FP-NEXT:    vmovx.f16 s6, s0
; CHECK-FP-NEXT:    vadd.f16 s0, s0, s6
; CHECK-FP-NEXT:    vadd.f16 s4, s1, s4
; CHECK-FP-NEXT:    vldr.16 s2, [r0]
; CHECK-FP-NEXT:    vadd.f16 s0, s0, s4
; CHECK-FP-NEXT:    vadd.f16 s0, s2, s0
; CHECK-FP-NEXT:    vstr.16 s0, [r0]
; CHECK-FP-NEXT:    bx lr
;
; CHECK-NOFP-LABEL: fadd_v4f16:
; CHECK-NOFP:       @ %bb.0: @ %entry
; CHECK-NOFP-NEXT:    vmovx.f16 s4, s0
; CHECK-NOFP-NEXT:    vadd.f16 s4, s0, s4
; CHECK-NOFP-NEXT:    vmovx.f16 s0, s1
; CHECK-NOFP-NEXT:    vadd.f16 s4, s4, s1
; CHECK-NOFP-NEXT:    vldr.16 s2, [r0]
; CHECK-NOFP-NEXT:    vadd.f16 s0, s4, s0
; CHECK-NOFP-NEXT:    vadd.f16 s0, s2, s0
; CHECK-NOFP-NEXT:    vstr.16 s0, [r0]
; CHECK-NOFP-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call fast half @llvm.experimental.vector.reduce.v2.fadd.f16.v4f16(half %y, <4 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc void @fadd_v8f16(<8 x half> %x, half* %yy) {
; CHECK-FP-LABEL: fadd_v8f16:
; CHECK-FP:       @ %bb.0: @ %entry
; CHECK-FP-NEXT:    vrev32.16 q1, q0
; CHECK-FP-NEXT:    vadd.f16 q0, q0, q1
; CHECK-FP-NEXT:    vadd.f16 s4, s2, s3
; CHECK-FP-NEXT:    vadd.f16 s0, s0, s1
; CHECK-FP-NEXT:    vldr.16 s2, [r0]
; CHECK-FP-NEXT:    vadd.f16 s0, s0, s4
; CHECK-FP-NEXT:    vadd.f16 s0, s2, s0
; CHECK-FP-NEXT:    vstr.16 s0, [r0]
; CHECK-FP-NEXT:    bx lr
;
; CHECK-NOFP-LABEL: fadd_v8f16:
; CHECK-NOFP:       @ %bb.0: @ %entry
; CHECK-NOFP-NEXT:    vmovx.f16 s4, s0
; CHECK-NOFP-NEXT:    vmovx.f16 s6, s1
; CHECK-NOFP-NEXT:    vadd.f16 s4, s0, s4
; CHECK-NOFP-NEXT:    vmovx.f16 s0, s3
; CHECK-NOFP-NEXT:    vadd.f16 s4, s4, s1
; CHECK-NOFP-NEXT:    vadd.f16 s4, s4, s6
; CHECK-NOFP-NEXT:    vmovx.f16 s6, s2
; CHECK-NOFP-NEXT:    vadd.f16 s4, s4, s2
; CHECK-NOFP-NEXT:    vldr.16 s2, [r0]
; CHECK-NOFP-NEXT:    vadd.f16 s4, s4, s6
; CHECK-NOFP-NEXT:    vadd.f16 s4, s4, s3
; CHECK-NOFP-NEXT:    vadd.f16 s0, s4, s0
; CHECK-NOFP-NEXT:    vadd.f16 s0, s2, s0
; CHECK-NOFP-NEXT:    vstr.16 s0, [r0]
; CHECK-NOFP-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call fast half @llvm.experimental.vector.reduce.v2.fadd.f16.v8f16(half %y, <8 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc void @fadd_v16f16(<16 x half> %x, half* %yy) {
; CHECK-FP-LABEL: fadd_v16f16:
; CHECK-FP:       @ %bb.0: @ %entry
; CHECK-FP-NEXT:    vadd.f16 q0, q0, q1
; CHECK-FP-NEXT:    vrev32.16 q1, q0
; CHECK-FP-NEXT:    vadd.f16 q0, q0, q1
; CHECK-FP-NEXT:    vadd.f16 s4, s2, s3
; CHECK-FP-NEXT:    vadd.f16 s0, s0, s1
; CHECK-FP-NEXT:    vldr.16 s2, [r0]
; CHECK-FP-NEXT:    vadd.f16 s0, s0, s4
; CHECK-FP-NEXT:    vadd.f16 s0, s2, s0
; CHECK-FP-NEXT:    vstr.16 s0, [r0]
; CHECK-FP-NEXT:    bx lr
;
; CHECK-NOFP-LABEL: fadd_v16f16:
; CHECK-NOFP:       @ %bb.0: @ %entry
; CHECK-NOFP-NEXT:    vmovx.f16 s8, s4
; CHECK-NOFP-NEXT:    vmovx.f16 s10, s0
; CHECK-NOFP-NEXT:    vadd.f16 s8, s10, s8
; CHECK-NOFP-NEXT:    vadd.f16 s10, s0, s4
; CHECK-NOFP-NEXT:    vadd.f16 s8, s10, s8
; CHECK-NOFP-NEXT:    vadd.f16 s10, s1, s5
; CHECK-NOFP-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NOFP-NEXT:    vmovx.f16 s10, s5
; CHECK-NOFP-NEXT:    vmovx.f16 s12, s1
; CHECK-NOFP-NEXT:    vmovx.f16 s4, s7
; CHECK-NOFP-NEXT:    vadd.f16 s10, s12, s10
; CHECK-NOFP-NEXT:    vmovx.f16 s12, s2
; CHECK-NOFP-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NOFP-NEXT:    vadd.f16 s10, s2, s6
; CHECK-NOFP-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NOFP-NEXT:    vmovx.f16 s10, s6
; CHECK-NOFP-NEXT:    vadd.f16 s10, s12, s10
; CHECK-NOFP-NEXT:    vmovx.f16 s0, s3
; CHECK-NOFP-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NOFP-NEXT:    vadd.f16 s10, s3, s7
; CHECK-NOFP-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NOFP-NEXT:    vadd.f16 s0, s0, s4
; CHECK-NOFP-NEXT:    vldr.16 s2, [r0]
; CHECK-NOFP-NEXT:    vadd.f16 s0, s8, s0
; CHECK-NOFP-NEXT:    vadd.f16 s0, s2, s0
; CHECK-NOFP-NEXT:    vstr.16 s0, [r0]
; CHECK-NOFP-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call fast half @llvm.experimental.vector.reduce.v2.fadd.f16.v16f16(half %y, <16 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc double @fadd_v1f64(<1 x double> %x, double %y) {
; CHECK-LABEL: fadd_v1f64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f64 d0, d1, d0
; CHECK-NEXT:    bx lr
entry:
  %z = call fast double @llvm.experimental.vector.reduce.v2.fadd.f64.v1f64(double %y, <1 x double> %x)
  ret double %z
}

define arm_aapcs_vfpcc double @fadd_v2f64(<2 x double> %x, double %y) {
; CHECK-LABEL: fadd_v2f64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f64 d0, d0, d1
; CHECK-NEXT:    vadd.f64 d0, d2, d0
; CHECK-NEXT:    bx lr
entry:
  %z = call fast double @llvm.experimental.vector.reduce.v2.fadd.f64.v2f64(double %y, <2 x double> %x)
  ret double %z
}

define arm_aapcs_vfpcc double @fadd_v4f64(<4 x double> %x, double %y) {
; CHECK-LABEL: fadd_v4f64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f64 d5, d1, d3
; CHECK-NEXT:    vadd.f64 d0, d0, d2
; CHECK-NEXT:    vadd.f64 d0, d0, d5
; CHECK-NEXT:    vadd.f64 d0, d4, d0
; CHECK-NEXT:    bx lr
entry:
  %z = call fast double @llvm.experimental.vector.reduce.v2.fadd.f64.v4f64(double %y, <4 x double> %x)
  ret double %z
}

define arm_aapcs_vfpcc float @fadd_v2f32_nofast(<2 x float> %x, float %y) {
; CHECK-LABEL: fadd_v2f32_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f32 s4, s4, s0
; CHECK-NEXT:    vadd.f32 s0, s4, s1
; CHECK-NEXT:    bx lr
entry:
  %z = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v2f32(float %y, <2 x float> %x)
  ret float %z
}

define arm_aapcs_vfpcc float @fadd_v4f32_nofast(<4 x float> %x, float %y) {
; CHECK-LABEL: fadd_v4f32_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f32 s4, s4, s0
; CHECK-NEXT:    vadd.f32 s4, s4, s1
; CHECK-NEXT:    vadd.f32 s4, s4, s2
; CHECK-NEXT:    vadd.f32 s0, s4, s3
; CHECK-NEXT:    bx lr
entry:
  %z = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v4f32(float %y, <4 x float> %x)
  ret float %z
}

define arm_aapcs_vfpcc float @fadd_v8f32_nofast(<8 x float> %x, float %y) {
; CHECK-LABEL: fadd_v8f32_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f32 s8, s8, s0
; CHECK-NEXT:    vadd.f32 s8, s8, s1
; CHECK-NEXT:    vadd.f32 s8, s8, s2
; CHECK-NEXT:    vadd.f32 s0, s8, s3
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    bx lr
entry:
  %z = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v8f32(float %y, <8 x float> %x)
  ret float %z
}

define arm_aapcs_vfpcc void @fadd_v4f16_nofast(<4 x half> %x, half* %yy) {
; CHECK-LABEL: fadd_v4f16_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vmovx.f16 s6, s0
; CHECK-NEXT:    vadd.f16 s4, s4, s0
; CHECK-NEXT:    vmovx.f16 s0, s1
; CHECK-NEXT:    vadd.f16 s4, s4, s6
; CHECK-NEXT:    vadd.f16 s4, s4, s1
; CHECK-NEXT:    vadd.f16 s0, s4, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call half @llvm.experimental.vector.reduce.v2.fadd.f16.v4f16(half %y, <4 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc void @fadd_v8f16_nofast(<8 x half> %x, half* %yy) {
; CHECK-LABEL: fadd_v8f16_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vmovx.f16 s6, s0
; CHECK-NEXT:    vadd.f16 s4, s4, s0
; CHECK-NEXT:    vmovx.f16 s0, s3
; CHECK-NEXT:    vadd.f16 s4, s4, s6
; CHECK-NEXT:    vmovx.f16 s6, s1
; CHECK-NEXT:    vadd.f16 s4, s4, s1
; CHECK-NEXT:    vadd.f16 s4, s4, s6
; CHECK-NEXT:    vmovx.f16 s6, s2
; CHECK-NEXT:    vadd.f16 s4, s4, s2
; CHECK-NEXT:    vadd.f16 s4, s4, s6
; CHECK-NEXT:    vadd.f16 s4, s4, s3
; CHECK-NEXT:    vadd.f16 s0, s4, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call half @llvm.experimental.vector.reduce.v2.fadd.f16.v8f16(half %y, <8 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc void @fadd_v16f16_nofast(<16 x half> %x, half* %yy) {
; CHECK-LABEL: fadd_v16f16_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldr.16 s8, [r0]
; CHECK-NEXT:    vmovx.f16 s10, s0
; CHECK-NEXT:    vadd.f16 s8, s8, s0
; CHECK-NEXT:    vmovx.f16 s0, s3
; CHECK-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NEXT:    vmovx.f16 s10, s1
; CHECK-NEXT:    vadd.f16 s8, s8, s1
; CHECK-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NEXT:    vmovx.f16 s10, s2
; CHECK-NEXT:    vadd.f16 s8, s8, s2
; CHECK-NEXT:    vmovx.f16 s2, s4
; CHECK-NEXT:    vadd.f16 s8, s8, s10
; CHECK-NEXT:    vadd.f16 s8, s8, s3
; CHECK-NEXT:    vadd.f16 s0, s8, s0
; CHECK-NEXT:    vadd.f16 s0, s0, s4
; CHECK-NEXT:    vadd.f16 s0, s0, s2
; CHECK-NEXT:    vmovx.f16 s2, s5
; CHECK-NEXT:    vadd.f16 s0, s0, s5
; CHECK-NEXT:    vadd.f16 s0, s0, s2
; CHECK-NEXT:    vmovx.f16 s2, s6
; CHECK-NEXT:    vadd.f16 s0, s0, s6
; CHECK-NEXT:    vadd.f16 s0, s0, s2
; CHECK-NEXT:    vmovx.f16 s2, s7
; CHECK-NEXT:    vadd.f16 s0, s0, s7
; CHECK-NEXT:    vadd.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %y = load half, half* %yy
  %z = call half @llvm.experimental.vector.reduce.v2.fadd.f16.v16f16(half %y, <16 x half> %x)
  store half %z, half* %yy
  ret void
}

define arm_aapcs_vfpcc double @fadd_v1f64_nofast(<1 x double> %x, double %y) {
; CHECK-LABEL: fadd_v1f64_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f64 d0, d1, d0
; CHECK-NEXT:    bx lr
entry:
  %z = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v1f64(double %y, <1 x double> %x)
  ret double %z
}

define arm_aapcs_vfpcc double @fadd_v2f64_nofast(<2 x double> %x, double %y) {
; CHECK-LABEL: fadd_v2f64_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f64 d2, d2, d0
; CHECK-NEXT:    vadd.f64 d0, d2, d1
; CHECK-NEXT:    bx lr
entry:
  %z = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v2f64(double %y, <2 x double> %x)
  ret double %z
}

define arm_aapcs_vfpcc double @fadd_v4f64_nofast(<4 x double> %x, double %y) {
; CHECK-LABEL: fadd_v4f64_nofast:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.f64 d4, d4, d0
; CHECK-NEXT:    vadd.f64 d0, d4, d1
; CHECK-NEXT:    vadd.f64 d0, d0, d2
; CHECK-NEXT:    vadd.f64 d0, d0, d3
; CHECK-NEXT:    bx lr
entry:
  %z = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v4f64(double %y, <4 x double> %x)
  ret double %z
}

declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v1f64(double, <1 x double>)
declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v2f64(double, <2 x double>)
declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v4f64(double, <4 x double>)
declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v2f32(float, <2 x float>)
declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v4f32(float, <4 x float>)
declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v8f32(float, <8 x float>)
declare half @llvm.experimental.vector.reduce.v2.fadd.f16.v16f16(half, <16 x half>)
declare half @llvm.experimental.vector.reduce.v2.fadd.f16.v2f16(half, <2 x half>)
declare half @llvm.experimental.vector.reduce.v2.fadd.f16.v4f16(half, <4 x half>)
declare half @llvm.experimental.vector.reduce.v2.fadd.f16.v8f16(half, <8 x half>)
