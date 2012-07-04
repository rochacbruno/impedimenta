/* prog3.c -- Jeremy Audet, Tue Oct 20 16:06:40 EDT 2009 */
/* determine whether a number is prime or not */
/*
ask for input integer;
scan for input;
pass value to function to check whether prime or not;
print out results;
END;

prime check!
take input;
while check is less than input and check is not true,
	if input is divisible by check,
		set check to true;
	repeat;
return check;
END;
*/


#include <stdio.h>
int primecheck(int input);

int main(void)
{
	int var1;

	printf("Please input an integer: ");
	scanf("%d", &var1);
	if(primecheck(var1))
		printf("The integer %d is prime.\n", var1);
	else
		printf("The integer %d is not prime.\n", var1);

	return 0;
}

int primecheck(int input)
{
	int divisor;
	int prime = 1;

	if(input < 2)
	{
		printf("Input is too small");
		prime = 0;
	}
	for(divisor = 2; prime == 1 && divisor < input; divisor++)
	{
		if((input % divisor) == 0)
			prime = 0;
	}

	return prime;
}
