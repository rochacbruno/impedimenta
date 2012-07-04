/* prog5.c -- This program tests various escape sequences and what happens when they are embedded into strings. */
#include <stdio.h>

int main(void)
{
	char char1 = '7';
	char char2 = '\x09'; //Escape sequence for tab

	printf("Test sequence one: **%c**\n", char1);
	printf("Test sequence two: **%c**\n", char2);
	printf("Test sequence three: **'\x09'**\n");
	printf("Test sequence four: **\x09**\n");
	printf("Test sequence five: **\a**\n"); //Escape sequence for alert
	printf("Test sequence six: **\b**\n"); //Escape sequence for backspace

	return 0;
}
