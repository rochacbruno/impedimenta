/* prog3.c -- Jeremy Audet, Tue Oct  6 15:37:38 EDT 2009 */
/*
hand value to square root function,
	square root value hands value to absolute value function,
		find absolute value of num;
		pass value back to parent function;
	find the square root of num;
	hand that value back to parent function;
print out results;
END;
*/

#include <stdio.h>
float avalue(float x);
float sroot(float x);

int main(void)
{
	printf("Square root of 2.0 = %f.\n", sroot(2.0));
	printf("Square root of 144.0 = %f.\n", sroot(144.0));
	printf("Square root of 17.5 = %f.\n", sroot(17.5));

	return 0;
}


float sroot(float x)
{
	const float epsilon = 0.0001;
	float guess = 1.0;

	while(avalue(guess * guess - x) >= epsilon)
		guess = (x / guess + guess)/2.0;

	return guess;
}

float avalue(float x)
{
	if(x < 0)
		x *= -1;

	return(x);
}
