/* prog1.c -- Jeremy Audet, Tue Oct 27 15:05:12 EDT 2009 */

#include <stdio.h>

int main(void)
{
	int array[20];
	int *pArray = array;

	printf("The size of a char is %d.\n", sizeof(char));
	printf("The size of a short is %d.\n", sizeof(short));
	printf("The size of a int is %d.\n", sizeof(int));
	printf("The size of a long is %d.\n", sizeof(long));
	printf("The size of a float is %d.\n", sizeof(float));
	printf("The size of a double is %d.\n", sizeof(double));
	printf("The size of a long double is %d.\n", sizeof(long double));
	printf("The size of a array is %d.\n", sizeof(array));
	printf("The size of a pArray is %d.\n", sizeof(pArray));

	return 0;
}
