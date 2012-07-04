/* prog0.c -- take user input, stop taking values upon receiving \n, change all values but whitespace, reprint */
#include <stdio.h>

int main(void)
{
	const char SPACE = ' ';
	char ch;

	ch = getchar();
	while (ch != '\n')
	{
		if (ch == SPACE)
			putchar(ch);
		else
			putchar(ch + 1);
		ch = getchar();
	}
	putchar(ch);

	return 0;
}
