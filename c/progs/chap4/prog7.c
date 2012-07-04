/* prog7.c -- Test out a simple printf statement with a control statement modifier. */
#include <stdio.h>

int main(void)
{
	printf("He sold the painting for $%2.3f.\n", 2.345e2);
	printf("Is %2.2e the same as %2.2f?\n", 1201.0, 1201.0);

	return 0;
}
