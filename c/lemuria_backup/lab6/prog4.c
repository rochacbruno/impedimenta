/* prog4.c -- Jeremy Audet, Tue Sep 29 15:56:31 EDT 2009 */
/* A sample program, I need to find the bugs using a debugger. */

#include <stdio.h>

int main(void)
{
	int number;					// Holds the number being tested
	int i;						// Holds the value being divided into number. Tests whether number is prime or not.
	int prime = 1;					// prime initialized // Holds a boolean which tells whether number is prime or not
	int upper;					// Eventually terminates the test loop if number is prime. Reset every time the test loop is run.

	printf("Enter a number: ");
	scanf("%d", &number);				// number initialized
	if(number < 2)
	{
		printf("Your number is too small.\n");
		return 1;
	}
	upper = number;					// upper initialized
	for(i = 2; i < upper && prime; i++)		// i initialized
	{
		if((number % i) == 0)
		{
			prime = 0;
		}
		else
		{
			upper = number / i;
		}
	}
	if(prime)
	{
		printf("The number %d is prime!\n", number);
	}
	else
	{
		printf("I'm sorry, %d is not prime. It can be divided by %d.\n", number, i - 1);
	}

	return 0;
}
