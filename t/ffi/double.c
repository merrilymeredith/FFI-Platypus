/*
 * DO NOT MODIFY THIS FILE.
 * This file generated from similar file t/ffi/float.c
 * all instances of "float" have been changed to "double"
 */
#include "libtest.h"
#ifdef HAVE_MATH_H
#include <math.h>
#endif

EXTERN double
double_add(double a, double b)
{
  return a + b;
}

EXTERN double*
double_inc(double *a, double b)
{
  static double keeper;
  keeper = *a += b;
  return &keeper;
}

EXTERN double
double_sum(double list[10])
{
  int i;
  double total;
  for(i=0,total=0; i<10; i++)
  {
    total += list[i];
  }
  return total;
}

EXTERN double
double_sum2(double *list, size_t size)
{
  int i;
  double total;
  for(i=0,total=0; i<size; i++)
  {
    total += list[i];
  }
  return total;
}

EXTERN void
double_array_inc(double list[10])
{
  int i;
  for(i=0; i<10; i++)
  {
    list[i]++;
  }
}

EXTERN double *
double_static_array(void)
{
  static double foo[] = { -5.5, 5.5, -10, 10, -15.5, 15.5, 20, -20, 25.5, -25.5 };
  return foo;
}

typedef double (*closure_t)(double);
static closure_t my_closure;

EXTERN void
double_set_closure(closure_t closure)
{
  my_closure = closure;
}

EXTERN double
double_call_closure(double value)
{
  return my_closure(value);
}

EXTERN int
double_is_4_2(double value)
{
  int ok = fabsf(4.2-value) < 0.001;
  return ok;
}

EXTERN const char *
double_is_4_2_diag(double value)
{
  static char buffer[1024];
  sprintf(buffer, "value = %f\noff by %f", value, fabs(4.2-value));
  return buffer;
}
