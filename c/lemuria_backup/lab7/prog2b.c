/* prog2b.c -- Jeremy Audet, Tue Oct  6 15:27:09 EDT 2009 */
/*
*/


#include <stdio.h>

int main(void)
{
	char ch;

	scanf("%c", &ch);
	while(ch != 'g')
	{
		printf("%c", ++ch);
		scanf("%c", &ch);
	}

	return 0;
}
