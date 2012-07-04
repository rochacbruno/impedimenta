/* Jeremy Audet */
/* declare two ints, read a value for the two ints, multiply them together and print the output */

#include <stdio.h>

int main(void)
{
	int num1, num2;

	puts("This program multiplies two integers together.");
	puts("Please enter two integers to multiply.");
	while(scanf("%d %d", &num1, &num2) != 2)
	{
		puts("Input error.");
		puts("Please enter two integers, separated only by spaces or [enter].");
	}
	printf("%d * %d == %d\n", num1, num2, num1 * num2);

	return 0;
}
