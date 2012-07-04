#include <stdio.h>
/* This program counts the number of characters input. */

int main(void)
{
	char ch = ' ';
	int letterCount = 0;
	int wordCount = 0;
	int inword = 0;

	printf ("I count occurences of words and characters in an input string!\n");
	printf ("Please, give me some input...\n");
	for(letterCount = -1, ch = ' '; ch != '\n'; letterCount++) {
		ch = getchar();
		if(ch != ' ' && ch != '\n' && inword == 0)
		{			// If interesting char is read and am
			wordCount++;	// not in word and user has not ended
			inword = 1;	// input, then...
		}
		else if (ch == ' ')	// If whitespace is read...
		{			// You're not in a word.
			inword = 0;
		}
		else			// If interesting character is read and
		{			// AM in word, then... so what. OK.
			;
		}
	}
	printf ("You have input %d characters.\n", letterCount);
	printf ("You have input %d words.\n", wordCount);
	printf ("Thank you.\n");

	return 0;
}
