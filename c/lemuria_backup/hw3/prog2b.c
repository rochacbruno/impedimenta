/* prog2.c -- Jeremy Audet */
/* check to see if a vowel exists in a string. print out results. repeat */

#include <stdio.h>
#include <strings.h>
#define TRUE 1
#define FALSE 0
_Bool letterfind(char ch, char * pLetter);

int main(void)
{
	char * pI;
	char ch;
	int found;
	char string1[40] = "I see, said the blind man, ";
	char string2[40] = "when he picked up his hammer and saw.";

	ch = 'a';
	pI = &string1[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string1\n", ch);
	else
		printf("The vowel %c was not found in string1\n", ch);
	ch = 'e';
	pI = &string1[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string1\n", ch);
	else
		printf("The vowel %c was not found in string1\n", ch);
	ch = 'i';
	pI = &string1[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string1\n", ch);
	else
		printf("The vowel %c was not found in string1\n", ch);
	ch = 'o';
	pI = &string1[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string1\n", ch);
	else
		printf("The vowel %c was not found in string1\n", ch);
	ch = 'u';
	pI = &string1[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string1\n", ch);
	else
		printf("The vowel %c was not found in string1\n", ch);
//------
	ch = 'a';
	pI = &string2[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string2\n", ch);
	else
		printf("The vowel %c was not found in string2\n", ch);
	ch = 'e';
	pI = &string2[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string2\n", ch);
	else
		printf("The vowel %c was not found in string2\n", ch);
	ch = 'i';
	pI = &string2[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string2\n", ch);
	else
		printf("The vowel %c was not found in string2\n", ch);
	ch = 'o';
	pI = &string2[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string2\n", ch);
	else
		printf("The vowel %c was not found in string2\n", ch);
	ch = 'u';
	pI = &string2[0];
	if(letterfind(ch , pI) == TRUE)
		printf("The vowel %c was found in string2\n", ch);
	else
		printf("The vowel %c was not found in string2\n", ch);

	return 0;
}

_Bool letterfind(char letter, char * pLetter)
{
	while(*pLetter != letter)
	{
		if(*pLetter == '\0')
			return FALSE;
		*pLetter++;
	}

	return TRUE;
}
