/* prog1.c -- Jeremy Audet, Tue Oct  6 15:11:09 EDT 2009 */
/*
set count to zero;
as long as count is less than 4,
	print "Hi! ";
	increment count;			// Runs 4 times (0 - 3)
print "Bye! ";
if count is less than 8,
	increment count;
	print "Bye! ";
END;
*/


#include <stdio.h>

int main(void)
{
	int i = 0;

	while(i++ < 4)
		printf("Hi! ");
	do
		printf("Bye! ");
	while(i++ < 8);
	putchar('\n');

	return 0;
}
