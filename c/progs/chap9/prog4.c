/* prog4.c -- Jeremy Audet */
/* programming exercise 4 from p. 345 */
/*
ask for an input number;
read number from input;
ask for another number;
read number from input;
find the harmonic mean of the two values (using harmonic());
take the harmonic mean and print it out to screen;
END;

harmonic()
take two values and store them;
find the inverse of the two numbers;
average the two numbers;
return the inverse of the average;
END;

END PSEUDOCODE!
*/

#include <stdio.h>
double harmonic(double x, double y);

int main(void)
{
	double a, b;
	char ch;

	puts("Please enter a number.");
	while(scanf("%lf", &a) != 1)
	{
		puts("Please enter a valid number.");
		while((ch = getchar()) != '\n')
			continue;
	}
	puts("Thank you. Please enter a second number.");
	while(scanf("%lf", &b) != 1)
	{
		puts("Please enter a second valid number.");
		while((ch = getchar()) != '\n')
			continue;
	}
	printf("The harmonic mean of %.2f and %.2f is %.2f.\n", a, b, harmonic(a, b));

	return 0;
}

double harmonic(double x, double y)
{
	x = 1 / x;
	y = 1 / y;

	return (1 / ((x + y) / 2));
}
