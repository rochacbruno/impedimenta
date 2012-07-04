/* prog2.c -- Jeremy Audet, Tue Oct 27 15:34:46 EDT 2009 */
/*
declare an array;

pass the array to getsize();
print out whatever getsize() returns;

END;
*/

#include <stdio.h>
int getsize1(int *n);

int main(void)
{
	int array[12];

	printf("Size of *n is %d, array[12] is %d.\n", getsize1(array), sizeof(array));

	return 0;
}

int getsize1(int *n)
{
	return sizeof(*n);
}
