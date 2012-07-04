/* This program uses the conditional operator ?: and uses it. */
#include <stdio.h>
#define COVERAGE = 200		//Square feet of coverage per paint can

int main(void)
{
	int sq_feet = 0;
	int cans = 0;

	printf("Enter he number of square feet to be painted:\n");
	while (scanf("%d", &sq_feet) == 1)
	{
		cans = sq_feet / COVERAGE;	//Note that this is an integer division operation.
		cans += ((sq_feet % COVERAGE == 0)) ? 0 : 1;
		printf("You need %d %s of paint.\n", cans, cans == 1 ? "can" : "cans");
		printf("Enter next value (q to quit):\n");
	}

	return 0;
}
