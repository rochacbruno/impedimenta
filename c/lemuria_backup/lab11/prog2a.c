/* prog2a.c -- Jeremy Audet */
/* read a file that does not exist. print out error message. */
/*
open a file for reading
if file cannot be read,
	print out error message;
	exit;
print out contents;
END;
*/
#include <stdio.h>
#include <stdlib.h>
#define FILENAME "word"

int main(void)
{
	char c;
	int ch;
	FILE *in;
	char string[50];

	if((in = fopen(FILENAME, "r")) == NULL)
	{
		printf("Error opening file \"%s\".\n", FILENAME);
		exit(1);
	}

	while(fscanf(in, "%c", &c) == 1)
		putchar(c);
	putchar('\n');

	if(fclose(in) != 0)
		printf("Error closing file \"%s\".\n", FILENAME);

	return 0;
}
