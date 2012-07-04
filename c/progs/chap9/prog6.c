#include <stdio.h>
#include "prog6.h"

int main(void)
{
	double num;
	int pow;

	puts("This program takes two numbers and raises the first by the second.");
	puts("Note that the first number is precise up to the millionth.");
	puts("The second number must be an integer.");
	puts("Please enter two numbers.");
	while(scanf("%lf %d", &num, &pow) != 2)
	{
		puts("Please enter a float and an int.");
		while(getchar() != '\n')
			continue;
	}
	printf("%.6e^%d = %.6e.\n", num, pow, power(num, pow));

	return 0;
}
