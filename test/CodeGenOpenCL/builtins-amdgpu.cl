// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -S -emit-llvm -o - %s | FileCheck %s --check-prefix=GCN --check-prefix=FUNC
// RUN: %clang_cc1 -triple r600-unknown-unknown -S -emit-llvm -o - %s | FileCheck %s --check-prefix=R600 --check-prefix=FUNC

// FUNC-LABEL: @test_get_work_dim(
// GCN: tail call i32 @llvm.amdgcn.read.workdim()
// R600: tail call i32 @llvm.r600.read.workdim()
int test_get_work_dim()
{
	return __builtin_get_work_dim();
}

// FUNC-LABEL: @test_get_num_groups(
// GCN: tail call i32 @llvm.r600.read.ngroups.x()
// GCN: tail call i32 @llvm.r600.read.ngroups.y()
// GCN: tail call i32 @llvm.r600.read.ngroups.z()
// R600: tail call i32 @llvm.r600.read.ngroups.x()
// R600: tail call i32 @llvm.r600.read.ngroups.y()
// R600: tail call i32 @llvm.r600.read.ngroups.z()
int test_get_num_groups(int d)
{
	return __builtin_get_num_groups(d);
}

// FUNC-LABEL: @test_get_global_size(
// GCN: tail call i32 @llvm.r600.read.global.size.x()
// GCN: tail call i32 @llvm.r600.read.global.size.y()
// GCN: tail call i32 @llvm.r600.read.global.size.z()
// R600: tail call i32 @llvm.r600.read.global.size.x()
// R600: tail call i32 @llvm.r600.read.global.size.y()
// R600: tail call i32 @llvm.r600.read.global.size.z()
int test_get_global_size(int d)
{
	return __builtin_get_global_size(d);
}

// FUNC-LABEL: @test_get_local_size(
// GCN: tail call i32 @llvm.r600.read.local.size.x()
// GCN: tail call i32 @llvm.r600.read.local.size.y()
// GCN: tail call i32 @llvm.r600.read.local.size.z()
// R600: tail call i32 @llvm.r600.read.local.size.x()
// R600: tail call i32 @llvm.r600.read.local.size.y()
// R600: tail call i32 @llvm.r600.read.local.size.z()
int test_get_local_size(int d)
{
	return __builtin_get_local_size(d);
}

// FUNC-LABEL: @test_get_group_id(
// GCN: tail call i32 @llvm.amdgcn.workgroup.id.x()
// GCN: tail call i32 @llvm.amdgcn.workgroup.id.y()
// GCN: tail call i32 @llvm.amdgcn.workgroup.id.z()
// R600: tail call i32 @llvm.r600.read.tgid.x()
// R600: tail call i32 @llvm.r600.read.tgid.y()
// R600: tail call i32 @llvm.r600.read.tgid.z()
int test_get_group_id(int d)
{
	return __builtin_get_group_id(d);
}

// FUNC-LABEL: @test_get_local_id(
// GCN: tail call i32 @llvm.amdgcn.workitem.id.x()
// GCN: tail call i32 @llvm.amdgcn.workitem.id.y()
// GCN: tail call i32 @llvm.amdgcn.workitem.id.z()
// R600: tail call i32 @llvm.r600.read.tidig.x()
// R600: tail call i32 @llvm.r600.read.tidig.y()
// R600: tail call i32 @llvm.r600.read.tidig.z()
int test_get_local_id(int d)
{
	return __builtin_get_local_id(d);
}

//TODO: enable offset
//int test_get_global_offset(int d)
//{
//	return __builtin_get_global_offset(d);
//}
