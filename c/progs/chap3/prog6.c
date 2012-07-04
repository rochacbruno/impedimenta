/* prog6.c -- This program takes a character and an escape sequence and prints it in several different formats. */
#include <stdio.h>

int main(void)
{
	char char1 = '7';
	char char2 = '\x33';

	printf("A character can only be assigned values using single quotes.\n");
	printf("What is inside those single quotes determines how the value is going to be assigned to the char.\n");
	printf("For example, char1 was assigned the character 7, and char2 was assigned the hex value 33.\n");
	printf("Char1: %c, %d, %#o, %#x.\n", char1, char1, char1, char1);
	printf("Char2: %c, %d, %o, %x.\n", char2, char2, char2, char2);

	return 0;
}
