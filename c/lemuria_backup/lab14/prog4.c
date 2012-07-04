/* Jeremy Audet */
/* prog4.c -- take a string, print it to stdout, then write it to a specified file. */
/*
declare a string;
declare a file pointer;
declare an int ch;

print the contents of the string to stdout;
open a file;
while '\0' has not been found,
	read a character from string;
	put character into file;
close file;
END;
*/

#include <stdio.h>
#include <stdlib.h>
#define OUTPUT "prog4-out.txt"

int main(void)
{
	const char string[] = "My age is 18, but sometimes my friends tell me I act like a fetus.";
	FILE *pFile;
	int ch;
	int num;

	printf("%s\n", string);
	if((pFile = fopen(OUTPUT, "w")) == NULL)
	{
		printf("Error opening file \"%s\".\n", OUTPUT);
		exit(1);
	}
	for(num = 0; (ch = string[num]) != '\0'; num++)
		putc(ch, pFile);
	putc('\n', pFile);
	if(fclose(pFile) != 0)
	{
		printf("Error closing file \"%s\".\n", OUTPUT);
		exit(1);
	}

	return 0;
}
