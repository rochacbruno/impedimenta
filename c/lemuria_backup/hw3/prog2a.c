#include <stdio.h>
#include <string.h>

int main(void)
{
	int i;
	char letter;
	char string1[40] = "I see, said the blind man, ";
	char string2[40] = "when he picked up his hammer and saw.";
	char vowels[6] = "aeiou";

	for(i = 0; (letter = vowels[i]) != '\0'; i++)
	{
		if(strchr(string1, letter) == NULL)
			printf("The letter %c was not found in string1.\n", letter);
		else
			printf("The letter %c was found in string1.\n", letter);
	}
	for(i = 0; (letter = vowels[i]) != '\0'; i++)
	{
		if(strchr(string2, letter) == NULL)
			printf("The letter %c was not found in string2.\n", letter);
		else
			printf("The letter %c was found in string2.\n", letter);
	}

	return 0;
}
