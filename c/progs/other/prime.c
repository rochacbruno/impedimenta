/* prime.c -- Jeremy Audet, Mon Sep 28 10:19:38 EDT 2009, adapted from code by Jean Hakim to understand better. */
/* input int; check for input error (must be > 1); try to find factor; if factor is found, print out factor; else, print out message */
#include <stdio.h>

int main(void)
{
	int number;
	int i;
	int prime;					//Holds boolean representing whether number is prime or not
	int upper;

	printf("Enter a number(2-65535): ");
	scanf("%d", &number);				//number initialized
	if(number < 2)
	{
		printf("Your number is too small.\n");
		return 1;
	}
	upper = number;					//upper initialized
	prime = 1;					//prime initialized
	for (i = 2; i < upper && prime; i++)		//i initialized
	{
		if(number % i == 0)
			prime = 0;
		else
			upper = number / i;
	}
	//Results!!!
	if(prime)
		printf("The number %d is prime!\n", number);
	else
		printf("I'm sorry, %d is not prime. It can be divided by %d.\n", number, i - 1);

	return 0;
}
