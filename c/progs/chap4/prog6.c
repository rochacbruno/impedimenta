/* prog6.c -- prints out ints in fields of varying widths. Overflow field. See what happens. */
#include <stdio.h>

int main(void)
{
	int val1 = 1000, val2 = 2000, val3 = 3000;

	printf("%10d %5d %1d\n", val1, val2, val3);
	printf("%10d%5d%1d\n", val1, val2, val3);
	printf("*%10d*%5d*%1d*\n", val1, val2, val3);

	return 0;
}
