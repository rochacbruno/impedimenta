/* echofile.c -- Jeremy Audet */
/* Read input from the user. Write input to a file. Echo the contents of that file. */
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
END PSEUDOCODE!
*/

#include <stdio.h>
#include <stdlib.h>
#define OUTPUT "testfile"		// for the sake of readability, two separate terms are used when testfile is used as input or output
#define INPUT "testfile"		// also makes the program more flexible

int main(void)
{
	FILE *in, *out;			// Input and output file pointers
	int ch;				// for reading characters and detecting EOF
	int position;			// for keeping track of position when writing out OUTPUT
//------
	if((out = fopen(OUTPUT, "w")) == NULL)					// open a file to use as output
	{
		printf("Error opening output file \"%s\".\n", OUTPUT);
		exit(1);
	}
	printf("All input will be written to \"%s\".\n", OUTPUT);
	puts("Please enter input(CTRL^D to quit):");
	while((ch = getchar()) != EOF)						// start writing output to file
	{
		putc(ch, out);
	}
	ch = '\n';
	putc(ch, out);								// end writing to file with a newline
	if(fclose(out) != 0)							// close file used for output
	{
		printf("Error closing output file \"%s\".\n", OUTPUT);
		exit(1);
	}
//------
	if((in = fopen(INPUT, "r")) == NULL)					// open the file that was just written to
	{
		printf("Error opening input file \"%s\".\n", INPUT);
		exit(1);
	}
	printf("\nInput was just written to the file \"%s\".\n", OUTPUT);
	printf("The contents of the file \"%s\" are as follows:\n\n", INPUT);
	while((ch = getc(in)) != EOF)						// print out everything in that file
		putchar(ch);
	putchar('\n');
	if(fclose(in) != 0)							// close file
	{
		printf("Error closing output file \"%s\".\n", INPUT);
		exit(1);
	}

	return 0;
}
