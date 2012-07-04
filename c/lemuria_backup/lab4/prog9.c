/* prog9.c -- exercise 6, page 265, lab 4 */
/* uses a switch and a postfix increment to print out four statements in a row. */
#include <stdio.h>

int main(void)
{
	int i = 0;

	while ( i < 3 )
	{
		switch(i++)
		{
			case 0 : printf("fat ");
			case 1 : printf("hat ");
			case 2 : printf("cat ");
			default: printf("Oh no!");
		}
		putchar('\n');
	}

	return 0;
}
