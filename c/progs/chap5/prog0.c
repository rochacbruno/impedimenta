/* prog0.c -- use the sizeof() function on a type. Scan a string and print out a message if string matches a certain value. Not in this order. */
#include <stdio.h>

int main(void)
{
	int size = 0;

	size = sizeof(long int);
	printf("A long int is %d bytes long.\n", size);

	return 0;
}
