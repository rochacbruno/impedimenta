/* prog13.c */

#include <stdio.h>
#include <ctype.h>
int get_first(void);

int main(void)
{
	printf("I print out the first non-whitespace character entered.\n");
	printf("Test me:\n");
	printf("The first non-whitespace character entered is %c\n", get_first());

	return 0;
}

int get_first(void)
{
	int ch;

	do{
		ch = getchar();
	}while(isspace(ch));

	return ch;
}
