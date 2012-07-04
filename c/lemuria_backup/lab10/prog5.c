/* prog7.c -- Jeremy Audet */
/*
while there is input,
	read a character;
	increment count;
print out results;
END;
*/

#include <stdio.h>

int main(void)
{
	int count = 0;

	while(getchar() != EOF)
		++count;
	printf("The number of characters read was %d.\n", count);

	return 0;
}
