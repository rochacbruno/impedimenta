/* Part 1. Declare 6 ints, and initialize the values. */

#include <stdio.h>

int main(void)
{
	int array[6] = {1, 2, 4, 8, 16, 32};
	int array2[100] = {[99] = -1};

	puts("array[2] == *(array + 2)");
	printf("The value of *(array + 2) == %d.\n", *(array + 2));
	printf("The value of *(array2 + 99) == %d.\n", *(array2 + 99));

	return 0;
}
