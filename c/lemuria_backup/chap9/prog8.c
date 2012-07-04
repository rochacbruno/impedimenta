#include <stdio.h>
#define TRUE 1
#define FALSE 0
double raise(double orig_num, int power);

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
	printf("%.6e^%d = %.6e.\n", num, pow, raise(num, pow));

	return 0;
}

double raise(double orig_num, int power)
{
	double temp;
	_Bool positive = TRUE;			// I'll assume that the number is positive unless found to be otherwise.

	if(orig_num == 0.000000)
		return 0.000000;
	if(power == 0)
		return 1.000000;
	if(power < 0)			// If power is negative, note this fact and make power positive.
	{
		positive = FALSE;
		power *= -1;
	}
	temp *= orig_num;		// Raise by a power, and...
	if(--power >= 1)		// ...there's one less power to use
		temp = raise(orig_num, power);
	if(positive == TRUE)
		temp = 1 / temp;

	return temp;
}
