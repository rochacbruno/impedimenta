/* prog3.c -- Jeremy Audet */
/* convert a string to all caps */

#include <stdio.h>
#include <string.h>

int main(void)
{
	int i;
	char ch;
	char string1[51] = "\"Help! I'm trapped in here. Can... can you help?\"";

	printf("Before editing, string1: %s\n", string1);
	for(i = 0; (ch = string1[i]) != '\0'; i++)
	{
		if(islower(ch))
			ch -= 32;
		string1[i] = ch;
	}
	printf("After editing, string1:  %s\n", string1);

	return 0;
}
