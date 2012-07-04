/* prog3.c -- Jeremy Audet, Tue Sep 29 15:44:16 EDT 2009 */
/*
make a variable, count, and set it to 0;
make a variable, num, and set it to 1;
check if num is > 3;
	if it is, increment count by 1;
	increment num by 1;
	repeat until num = 10 (don't check if 11 > 3);
print out results;
END
*/

#include <stdio.h>

int main(void)
{
	int count = 0;
	int num = 1;

	for( ; num <= 10; num++)
	{
		if(num > 3)
			++count;
	}
	printf("The loop ran %d times.\n", num - 1);
	printf("From 1 to %d, %d numbers are > 3.\n", num - 1, count);

	return 0;
}

