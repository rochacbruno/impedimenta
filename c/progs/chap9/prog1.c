/* prog1.c -- Jeremy Audet */
/* print out the binary equivalent of a decimal number (without using a scanf() modifier) */
/*
ask for input;
scan for input int;
while input is an int,
	while(num / divisor >= 1),
		divisor *= 2;
	divisor /= 2;
	while divisor is greater than 0,		// if divisor is greater than 0, not all powers of two (power of two == binary digit) have been exhausted
		if num / divisor > 0,
			print 1;
			num -= divisor;
		else,
			print 0;
		divisor /= 2;
newline;
END;
*/

#include <stdio.h>

int main(void)
{
	int num;
	int divisor;

	printf("Please enter an int(q to quit): ");
	while(scanf("%d", &num) == 1)
	{
		divisor = 1;
		while(num / divisor >= 1)
			divisor *= 2;
		divisor /= 2;
		printf("Binary equivalent:              ");
		while(divisor > 0)
		{
			if(num / divisor > 0)
			{
				putchar('1');
				num -= divisor;
			}
			else
				putchar('0');
			divisor /= 2;
		}
		if(num != '\n')
			while(getchar() != '\n')
				continue;
		printf("\nPlease enter an int(q to quit): ");
	}

	return 0;
}
