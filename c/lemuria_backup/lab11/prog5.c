/* prog5.c -- Jeremy Audet */
/*
read input from stdin
write everything to file
signal end of input stream with CTRL^D
close file
then open again and print to stdout
close
end
*/
/*
ask for input;
start reading input;
while CTRL^D is not encountered,
	write output to file;
add newline to file;
close file;
open file;
read character;
while character is not EOF,
	print to stdout;
print newline;
close file;
END;
*/

#include <stdio.h>
#include <stdlib.h>
#define OUTPUT "wordy2"

int main(void)
{
	FILE *in, *out;			// Input and output file pointers
	int ch;				// for reading characters and detecting EOF
	int position;			// for keeping track of position when writing out OUTPUT

	if((out = fopen(OUTPUT, "w")) == NULL)
	{
		printf("Error opening output file \"%s\".\n", OUTPUT);
		exit(1);
	}
	printf("All input will be written to \"%s\".\n", OUTPUT);
	puts("Please enter input(CTRL^D to quit):");
	while((ch = getchar()) != EOF)
	{
		putc(ch, out);
	}
	ch = '\n';
	putc(ch, out);
	if(fclose(out) != 0)
	{
		printf("Error closing output file \"%s\".\n", OUTPUT);
		exit(1);
	}

	/*if((in = fopen(OUTPUT, "r")) == NULL)
	{
		printf("Error opening input file \"%s\".\n", OUTPUT);
		exit(1);
	}*/
	

	return 0;
}
