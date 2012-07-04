/* prog5.c -- Jeremy Audet, Tue Sep 22 16:21:11 EDT 2009 */
/* print out a set of characters... i'll figure it out */
#include <stdio.h>

int main(void)
{
	const int ROWS = 6;
	const int CHARS = 6;
	int row;
	char ch;

	for(row = 0; row < ROWS; row++)
	{
		for(ch = ('A' + row); ch < ('A' + CHARS); ch++)
		{
			printf("%c", ch);
		}
		printf("\n");
	}

	return 0;
}
