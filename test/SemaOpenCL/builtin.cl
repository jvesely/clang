// RUN: %clang_cc1 %s -verify -pedantic -fsyntax-only

// expected-no-diagnostics

float __attribute__((overloadable)) acos(float);

typedef float float4 __attribute__((ext_vector_type(4)));
int printf(__constant const char* st, ...);

void test(void)
{
  float4 a;
  printf("%8.4v4hlf\n", a);
}

int test_get_work_dim()
{
	return __builtin_get_work_dim();
}

int test_get_num_groups(int d)
{
	return __builtin_get_num_groups(d);
}

int test_get_global_size(int d)
{
	return __builtin_get_global_size(d);
}

int test_get_local_size(int d)
{
	return __builtin_get_global_size(d);
}

int test_get_group_id(int d)
{
	return __builtin_get_group_id(d);
}


int test_get_local_id(int d)
{
	return __builtin_get_global_size(d);
}

int test_get_global_offset(int d)
{
	return __builtin_get_global_size(d);
}
