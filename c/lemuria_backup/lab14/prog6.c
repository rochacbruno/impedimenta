/* Jeremy Audet */
/* prog6.c -- make a structure called animals with a couple members, read input from the keyboard into the structure, and write the contents of the 
structure to a file called animals.out */
/*
declare a file pointer;			// write input to file
declare char ch;			// hold chars from keyboard to structure, and from structure to file
declare struct animals;			// struct to hold input

***** REPEAT x3
ask for cat name;
get character;
while input is not [enter] && structure field has not been filled
	put character into structure field;
append '\0' to structure field;
clear input buffer;
***** END REPEAT

open file;
while there are errors
	inform user of error;
	quit program;

***** REPEAT x3
get character from first structure field;
while character is not EOS,
	put character into file;
put newline in file;
***** END REPEAT

close file;
while there are errors,
	inform user of error;
	quit program;

END;
*/

#include <stdio.h>
#include <stdlib.h>
#define OUTFILE "animals.out"
#define FIELDSIZE 21		// fieldsize = contents + 1

struct info {
	char cat[FIELDSIZE];
	char dog[FIELDSIZE];
	char breed[FIELDSIZE];
	};

int main(void)
{
	FILE *pFile;
	char ch;
	int num;
	struct info animals;

	puts("Please enter a cat name.");
	for(num = 0; (ch = getchar()) != '\n' && num < FIELDSIZE - 1; num++)
		animals.cat[num] = ch;
	animals.cat[num] = '\0';
	if(ch != '\n')
		while(getchar() != '\n')
			continue;
//----still reading input
        puts("Please enter a dog name.");
        for(num = 0; (ch = getchar()) != '\n' && num < FIELDSIZE - 1; num++)
                animals.dog[num] = ch;
        animals.dog[num] = '\0';
	if(ch != '\n')
		while(getchar() != '\n')
			continue;
//----still reading input
        puts("Please enter a breed name.");
        for(num = 0; (ch = getchar()) != '\n' && num < FIELDSIZE - 1; num++)
                animals.breed[num] = ch;
        animals.breed[num] = '\0';
	if(ch != '\n')
		while(getchar() != '\n')
			continue;

	while((pFile = fopen(OUTFILE, "w")) == NULL)
	{
		printf("Error opening file \"%s\".\n", OUTFILE);
		exit(1);
	}

	for(num = 0; (ch = animals.cat[num]) != '\0'; num++)
		putc(ch, pFile);
	putc('\n', pFile);
//----still writing to file				
        for(num = 0; (ch = animals.dog[num]) != '\0'; num++)
                putc(ch, pFile);
	putc('\n', pFile);
//----still writing to file
        for(num = 0; (ch = animals.breed[num]) != '\0'; num++)
                putc(ch, pFile);
	putc('\n', pFile);

	while(fclose(pFile) != 0)
	{
		printf("Error closing file \"%s\".\n", OUTFILE);
		exit(1);
	}

	return 0;
}
