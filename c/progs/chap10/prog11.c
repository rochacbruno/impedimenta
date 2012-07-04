/* prog11.c -- Jeremy Audet. Design a simple function to print out a passed function. */

#include <stdio.h>

void print_int_array(int source[], int length);

int main(void)
{
	int array1[10] = {[5] = 6, 7, 8, 9, 10};
	int array2[4] = {0, 1, 2, 3};

	print_int_array(array1, 10);
	print_int_array(&array2[2], 2);

	return 0;
}

void print_int_array(int source[], int length)
{
	int index;

	for(index = 0; index < length; index++)
		printf("%d ", source[index]);
	putchar('\n');
}
