/* prog5.c -- request a float; pass float to prototype function; print the cube of float; */
#include <stdio.h>

int cube(float n);
int main(void)
{
	float var1 = 0;

	printf("Please enter a value to cube: ");
	scanf("%f", &var1);
	cube(var1);

	return 0;
}

int cube(float n)
{
	printf("%.4e cubed is %.4e.\n", n, n * n * n);

	return 0;
}
