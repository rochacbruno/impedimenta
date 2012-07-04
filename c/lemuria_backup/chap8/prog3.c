/* prog3.c -- Jeremy Audet */
/* call a function */

#include <stdio.h>
int function(int num);

int main(void)
{
	int var1 = 10;

	printf("%d squared is %d.\n", var1, function(var1));

	return 0;
}

int function(int num)
{
	int result;

	result = num * num;
	return result;
}
