/* prog3b.c -- Jeremy Audet, Tue Oct 20 16:38:05 EDT 2009 */
/* calculate and print out all the primes between 1 and 10000 */


#include <stdio.h>
int prime(int n);

int main(void)
{
	int loop;
	int count = 0;

	printf("The prime numbers between 1 and 10000 are as follows:\n");
	for(loop = 1; loop <= 10000; loop++)
	{
		if(prime(loop))
		{
			count++;
			printf("%6d", loop);
			if((count % 10) == 0)
				putchar('\n');
		}
	}

	return 0;
}

int prime(int n)
{
	int loop2;

	for(loop2 = 2; loop2 <= (n / 2); loop2++)
	{
		if((n % loop2) == 0)
			return 0;
	}

	return 1;
}
