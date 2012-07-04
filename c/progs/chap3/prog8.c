/* prog8.c -- part of chapter 3 review. See answers.txt */
#include <stdio.h>

int main(void)
{
	float g, h, tax, rate;

	g = 1e21;
	rate = 0.15;
	tax = rate * g;
	printf("The total tax is %e.\n", tax);

	return 0;
}
