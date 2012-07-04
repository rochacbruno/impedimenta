/* prog2a.c -- Jeremy Audet, Tue Oct  6 15:24:39 EDT 2009 */
/* 
*/


#include <stdio.h>

int main(void)
{
	char ch;

	scanf("%c", &ch);
	while(ch != 'g')
	{
		printf("%c", ch);
		scanf("%c", &ch);
	}

	return 0;
}
