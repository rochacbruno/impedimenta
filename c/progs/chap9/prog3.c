/* prog3.c -- Jeremy Audet */
/* driver program that uses a min() function to find the lesser of two values */

#include <stdio.h>
int min(int x, int y);

int main(void)
{
	int a = 15;
	int b = -1234;

	printf("The lesser of %d and %d is %d.\n", a, b, min(a, b));

	return 0;
}

int min(int x, int y)
{
	if(x < y)
		return x;
	else
		return y;
}
