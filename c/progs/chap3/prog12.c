/*prog12.c -- purposely overflow integer and float, and underflow float. See what happens. */
#include <stdio.h>
#include <limits.h>
#include <float.h>

int main(void)
{
	printf("Maximum int value: %d.\n", INT_MAX);
	printf("Maximum float value: %e.\n", FLT_MAX);
	printf("Minimum float value: %10.10e.\n\n", FLT_MIN);

	printf("INT_MAX + 1 = %d, INT_MAX + 2 = %d.\n", INT_MAX + 1, INT_MAX + 2);
	printf("FLT_MAX + 1 = %e, FLT_MAX + 2 = %e.\n", FLT_MAX + 1, FLT_MAX + 2);
	printf("FLT_MIN - 1 = %10.10e, FLT_MIN / 10 = %10.10e.\n", (FLT_MIN - 1), (FLT_MIN / 10));

	return 0;
}
