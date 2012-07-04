/* prog3.c -- Jeremy Audet */
/* cat one string onto the second. print out the strings before and after concatenation. cat the first two letters of one string onto the second. print out the string before and after concatenation. */

#include <stdio.h>
#include <string.h>
#define cString1 "String one"
#define cString2 "String two"

int main(void)
{
	int i = 0;							// Used to cycle through the letters of an array, one at a time
	char ch;							// Stores the current character while cycling through an array
	char string1[20] = {cString2};
	char string2[20] = {cString1};

	printf("string1 before catting string2: %s\n", string1);
	printf("string2 before catting string2: %s\n", string2);
	strcat(string1, string2);					// cat all of string2 onto string1
	printf("string1 after catting string2:  %s\n", string1);
//------
	for(i = 0; (ch = cString1[i]) != '\0'; i++)			// Until reaching the end of the reference array...
		string1[i] = ch;					// ...set the corresponding character in the used array to the same value.
	string1[i] = ch;						// The loop above will not end the string with a null character
	for(i = 0; (ch = cString2[i]) != '\0'; i++)
		string2[i] = ch;
	string2[i] = ch;
	printf("string1 before catting 2 chars: %s\n", string1);
	printf("string2 before catting 2 chars: %s\n", string2);
	strncat(string1, string2, 2);					// cat the first two characters of string2 onto string1
	printf("string1 after catting 2 chars:  %s\n", string1);

	return 0;
}
