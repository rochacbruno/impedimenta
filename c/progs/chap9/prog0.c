/* prog0.c -- Jeremy Audet */
/* rewrite of program on page 308 */
/* print out a centered letterhead */
/*
start;
print out line of stars;
see how many spaces are used;
print out whitespace equal to half the available space;
print out name and address;
print out line of stars;
END;
*/
/*
define print_n_chars;

print out WIDTH stars;
find out how many characters line 1 of address uses;
print out ((WIDTH - usedchars) / 2) whitespace characters;
print out line 1 of address;
find out how many characters line 2 of address uses;
print out ((WIDTH - usedchars) / 2) whitespace characters;
print out line 2 of address;
find out how many characters line 3 of address uses;
print out ((WIDTH - usedchars) / 2) whitespace characters;
print out line 3 of address;
print out WIDTH stars;
END;
*/

#include <stdio.h>
#include <string.h>
#define NAME "Jeremy Audet"
#define ADDRESS1 "725 VT Route 15"
#define ADDRESS2 "Underhill, VT, 05489"
#define WIDTH 40
#define SPACE ' '

void print_n_chars(char ch, int limit);			// char ch is the character to print, num says how many times to print

int main(void)
{
	print_n_chars('*', WIDTH);			// star bar
	putchar('\n');
	print_n_chars(SPACE, (WIDTH - strlen(NAME)) / 2);	// name
	printf("%s\n", NAME);
	print_n_chars(SPACE, (WIDTH - strlen(ADDRESS1)) / 2);	//address line 1
	printf("%s\n", ADDRESS1);
	print_n_chars(SPACE, (WIDTH - strlen(ADDRESS2)) / 2); 	//address line 2
	printf("%s\n", ADDRESS2);	
	print_n_chars('*', WIDTH);
	putchar('\n');

	return 0;
}

void print_n_chars(char ch, int limit)
{
	int count;

	for(count = 1; count <= limit; count++)
		putchar(ch);
}
