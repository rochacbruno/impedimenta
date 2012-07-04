/* prog5.c -- Jeremy Audet */
/* take a user-specified number, and raise it to a user-specified power */
/*
main()
ask for input number and power (float and int);
read in two floats;
while input is not valid,
	tell user that input is not valid;
	flush input buffer;
	ask for a number and power;
hand off numbers to power() function;
print out results of power();
END;
END PSEUDOCODE!
*/

#include <stdio.h>
#define TRUE 1
#define FALSE 0
double power(double orig_num, int power);

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

double power(double orig_num, int power)
{
	double temp;
	_Bool negative = FALSE;			// I'll assume that the number is positive unless found to be otherwise.

	if(orig_num == 0.000000)
		return 0.000000;
	if(power == 0)
		return 1.000000;
	if(power < 0)			// If power is negative, note this fact and make power positive.
	{
		negative = TRUE;
		power *= -1;
	}
	for(temp = 1.000000; power >= 1; power--)		// This statement raises the number to the specified power
		temp *= orig_num;
	if(negative == TRUE)
		temp = 1 / temp;

	return temp;
}
