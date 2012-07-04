/* prog3.c -- Jeremy Audet */
/* listing 13.5, page 513 */
#include <stdio.h>
#include <stdlib.h>
#define CNTL_Z '\032'
#define SLEN 50
#define OUTPUT "wordy2"

int main(void)
{
	char file[SLEN];
	char ch;
	FILE *in, *out;
	long count, last;

	puts("Enter the name of the file to be processed:");
	gets(file);
	if((in = fopen(file,"rb")) == NULL)
	{
		printf("reverse can't open %s\n", file);
		exit(1);
	}

	if((out = fopen(OUTPUT, "w")) == NULL)
	{
		printf("Error opening output file %s.\n", OUTPUT);
		exit(1);
	}

	fseek(in, 0L, SEEK_END);
	last = ftell(in);
	for(count = 1L; count <= last; count++)
	{
		fseek(in, -count, SEEK_END);
		ch = getc(in);
		if(ch != CNTL_Z && ch != '\r')
			putc(ch, out);
	}
	ch = '\n';
	putc(ch, out);
	fclose(in);
	fclose(out);

	return 0;
}

