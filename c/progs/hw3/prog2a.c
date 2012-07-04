#include <stdio.h>
#include <string.h>

int main(void)
{
	int i;									// Used when choosing which vowel to check for
	char letter;								// The current letter I am checking for
	char string1[40] = "I see, said the blind man, ";			// Create two strings to check for vowels
	char string2[40] = "when he picked up his hammer and saw.";
	char vowels[6] = "aeiou";						// Letters to check for

	for(i = 0; (letter = vowels[i]) != '\0'; i++)				// Check for one vowel at a time
	{
		if(strchr(string1, letter) == NULL)				// Check for the existence of the current vowel, and let the user know
			printf("The letter %c was not found in string1.\n", letter);
		else
			printf("The letter %c was found in string1.\n", letter);
	}
	for(i = 0; (letter = vowels[i]) != '\0'; i++)				// Checking string2 just like string1
	{
		if(strchr(string2, letter) == NULL)
			printf("The letter %c was not found in string2.\n", letter);
		else
			printf("The letter %c was found in string2.\n", letter);
	}

	return 0;
}
