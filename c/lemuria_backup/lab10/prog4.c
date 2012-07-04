/* prog4.c -- use conversion specifiers. */
/*
a. %d
b. %i
c. %d as positive
d. %d as negative
e. %o
f. %u
g. %u as negative
*/
#include <stdio.h>

int main(void)
{
	int num = 455;

	printf("a. %d\n", num);
	printf("b. %i\n", num);
	printf("c. %+d\n", num);
	num *= -1;
	printf("d. %+d\n", num);		// negative
	num *= -1;
	printf("e. %o\n", num);
	printf("f. %u\n", num);
	num *= -1;
	printf("g. %u\n", num);			// negative

	return 0;
}
