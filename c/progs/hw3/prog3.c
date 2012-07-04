/* prog3.c -- Jeremy Audet */
/* convert a string to all caps */

#include <stdio.h>
#include <string.h>

int main(void)
{
	int i;							// Used to cycle through all of the characters in a specified array
	char ch;						// Stores the letter I am checking
	char string1[51] = "\"Help! I'm trapped in here. Can... can you help?\"";

	printf("Before editing, string1: %s\n", string1);
	for(i = 0; (ch = string1[i]) != '\0'; i++)		// Run through the characters of the array, one at a time
	{
		if(islower(ch))					// If the letter is lowercase...
			ch -= 32;				// ...convert to uppercase...
		string1[i] = ch;				// ...and replace the old letter in the array.
	}
	printf("After editing, string1:  %s\n", string1);

	return 0;
}
