/* prog11.c -- problem #4, p. 302 */
/*
while there is still input,
	read a letter;
	if it is whitespace,
		calculate average word length;
	else if it is punctuation,
		continue(letter is not counted);
	else,
		increment lettercount;
print out results;
END;
*/

#include <stdio.h>
#include <ctype.h>
#define TRUE 1
#define FALSE 0

int main(void)
{
	int ch;
	_Bool inword = FALSE;		// Currently in word?
	int lettercount = 0;		// Number of letters in current word
	float average = 0;		// Average number of letters per word
	int words = 0;			// Words keeps track of the current number of words used.

	while((ch = getchar()) != EOF)
	{
		if(isspace(ch) && inword == TRUE)					// If whitespace is found && currently in word,
		{
			average = (average * (float)words + (float)lettercount) / ((float)words + 1);	// First usage of words refers to the number of words that comprise the average...
			++words;							// ...second usage of words tells how many words comprise the current average;
			lettercount = 0;						// Reset the number of letters in the current word to zero.
			inword = FALSE;
		}
		else if(ispunct(ch))
			continue;							// If punctuation, do not count as part of word, but do not count as end of word either.
		else
		{
			++lettercount;							// If last character was something other than whitespace or punctuation, it should be counted as part of a word.
			inword = TRUE;							// In word if last character was something other than whitespace or punctuation.
		}
	}
	printf("There were %d words.\n", words);
	printf("The average length of each word was %.2f.\n", average);

	return 0;
}
