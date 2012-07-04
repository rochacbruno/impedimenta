/* prog1.c -- take user input and add 1 to the ascii value of all alphabetic characters, stop taking input when '\n' is encountered, print out modified input. */
#include <stdio.h>
#include <ctype.h>

int main(void)
{
	char ch;

	while((ch = getchar()) != '\n')
	{
		if (isalpha(ch))
			putchar(ch + 1);
		else
			putchar(ch);
	}
	putchar(ch);

	return 0;
}
