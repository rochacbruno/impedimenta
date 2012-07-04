/* prog1.c -- take an int, print out value, convert int to float and perform math, print out value again, see if int is permanently changed. */
#include <stdio.h>

int main(void)
{
	int var1 = 5;
	float var2 = 12.68;

	printf("int: %d, float: %0.2f.\n", var1, var2);
	printf("(float) var1 + var2 = %0.2f\n", (float) var1 + var2);
	printf("int: %d, float: %0.2f.\n", var1, var2);

	return 0;
}
