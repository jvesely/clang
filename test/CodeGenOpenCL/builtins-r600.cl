// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple r600-unknown-unknown -S -emit-llvm -o - %s | FileCheck %s

#pragma OPENCL EXTENSION cl_khr_fp64 : enable

// CHECK-LABEL: @test_rsq_f32
// CHECK: call float @llvm.r600.rsq.f32
void test_rsq_f32(global float* out, float a)
{
  *out = __builtin_amdgpu_rsqf(a);
}

// CHECK-LABEL: @test_rsq_f64
// CHECK: call double @llvm.r600.rsq.f64
void test_rsq_f64(global double* out, double a)
{
  *out = __builtin_amdgpu_rsq(a);
}

// CHECK-LABEL: @test_legacy_ldexp_f32
// CHECK: call float @llvm.AMDGPU.ldexp.f32
void test_legacy_ldexp_f32(global float* out, float a, int b)
{
  *out = __builtin_amdgpu_ldexpf(a, b);
}

// CHECK-LABEL: @test_legacy_ldexp_f64
// CHECK: call double @llvm.AMDGPU.ldexp.f64
void test_legacy_ldexp_f64(global double* out, double a, int b)
{
  *out = __builtin_amdgpu_ldexp(a, b);
}

// CHECK-LABEL: @test_get_work_dim(
// CHECK: tail call i32 @llvm.r600.read.workdim()
void test_get_work_dim(global int* out)
{
  *out = __builtin_r600_read_workdim();
}

// CHECK-LABEL: @test_get_num_groups(
// CHECK: tail call i32 @llvm.r600.read.ngroups.x()
// CHECK: tail call i32 @llvm.r600.read.ngroups.y()
// CHECK: tail call i32 @llvm.r600.read.ngroups.z()
void test_get_num_groups(int d, global int *out)
{
	switch (d) {
	case 0: *out = __builtin_r600_read_ngroups_x(); break;
	case 1: *out = __builtin_r600_read_ngroups_y(); break;
	case 2: *out = __builtin_r600_read_ngroups_z(); break;
	default: *out = 1;
	}
}

// CHECK-LABEL: @test_get_global_size(
// CHECK: tail call i32 @llvm.r600.read.global.size.x()
// CHECK: tail call i32 @llvm.r600.read.global.size.y()
// CHECK: tail call i32 @llvm.r600.read.global.size.z()
void test_get_global_size(int d, global int *out)
{
	switch (d) {
	case 0: *out = __builtin_r600_read_global_size_x(); break;
	case 1: *out = __builtin_r600_read_global_size_y(); break;
	case 2: *out = __builtin_r600_read_global_size_z(); break;
	default: *out = 1;
	}
}

// CHECK-LABEL: @test_get_local_size(
// CHECK: tail call i32 @llvm.r600.read.local.size.x()
// CHECK: tail call i32 @llvm.r600.read.local.size.y()
// CHECK: tail call i32 @llvm.r600.read.local.size.z()
void test_get_local_size(int d, global int * out)
{
	switch (d) {
	case 0: *out = __builtin_r600_read_local_size_x(); break;
	case 1: *out = __builtin_r600_read_local_size_y(); break;
	case 2: *out = __builtin_r600_read_local_size_z(); break;
	default: *out = 1;
	}
}

// CHECK-LABEL: @test_get_group_id(
// CHECK: tail call i32 @llvm.r600.read.tgid.x()
// CHECK: tail call i32 @llvm.r600.read.tgid.y()
// CHECK: tail call i32 @llvm.r600.read.tgid.z()
void test_get_group_id(int d, global int *out)
{
	switch (d) {
	case 0: *out = __builtin_r600_read_tgid_x(); break;
	case 1: *out = __builtin_r600_read_tgid_y(); break;
	case 2: *out = __builtin_r600_read_tgid_z(); break;
	default: *out = 0;
	}
}

// CHECK-LABEL: @test_get_local_id(
// CHECK: tail call i32 @llvm.r600.read.tidig.x()
// CHECK: tail call i32 @llvm.r600.read.tidig.y()
// CHECK: tail call i32 @llvm.r600.read.tidig.z()
void test_get_local_id(int d, global int *out)
{
	switch (d) {
	case 0: *out = __builtin_r600_read_tidig_x(); break;
	case 1: *out = __builtin_r600_read_tidig_y(); break;
	case 2: *out = __builtin_r600_read_tidig_z(); break;
	default: *out = 0;
	}
}

// CHECK-LABEL: @test_get_global_offset(
// CHECK: tail call i32 @llvm.r600.read.global.offset.x()
// CHECK: tail call i32 @llvm.r600.read.global.offset.y()
// CHECK: tail call i32 @llvm.r600.read.global.offset.z()
int test_get_global_offset(int d, global int *out)
{
	switch (d) {
	case 0: *out = __builtin_r600_read_global_offset_x(); break;
	case 1: *out = __builtin_r600_read_global_offset_y(); break;
	case 2: *out = __builtin_r600_read_global_offset_z(); break;
	default: *out = 0;
	}
}
