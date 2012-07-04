/* prog4.c -- answer to question #4 on lab 4. listing 7.7 on page 244. */
/* Takes characters from standard input and counts all the words, letters, and lines input. */
#include <stdio.h>
#include <ctype.h> //For isspace()
#include <stdbool.h>
#define STOP '|'

int main(void)
{
	char c;			//Reads each new character
	char prev;		//Previous character read
	long n_chars = 0L;	//Number of characters, total
	int n_lines = 0;	//Number of lines, total
	int n_words = 0; 	//Number of words, total
	int p_lines = 0;	//Number of partial lines, total
	bool inword = false;	// == true if c is in a word

	printf("Enter text to be analyzed (| to terminate):\n");
	prev = '\n';		// Identifies complete lines. 
	while ((c = getchar()) != STOP)
	{
		n_chars++;	// This counts characters!
		if (c == '\n')	// This counts newlines!
			n_lines++;
		if (!isspace(c) && !inword)
		{
			inword = true;	//Starting a new word
			n_words++;	//This counts new words!
		}
		if (isspace(c) && inword)
			inword = false;	//reached end of word
		prev = c;
	}

	if (prev != '\n')
		p_lines = 1;
	printf("characters = %ld, words = %d, lines = %d, ", n_chars, n_words, n_lines);
	printf("partial lines = %d\n", p_lines);

	return 0;
}
