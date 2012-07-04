/* prog5.c -- Jeremy Audet, Wed Sep 30 10:37:44 EDT 2009 */
/*
ask for input strings;
read a character;
while input is not #,
	if character is whitespace,
		increment whitespace count;
	else if character is newline,
		increment newline count
	else,
		increment other character count;
	read another character;
	repeat;
print whitespace count;
print newline count;
print other character count;
(print out string input?);
END;
*/


#include <stdio.h>

int main(void)
{
	char ch;
	int whitecount = 0, newcount = 0, othercount = 0;	// whitecount initialized, newcount initialized, othercount initialized

	printf("Please input text(# to quit): ");
	ch = getchar();
	while(ch != '#')
	{
		if(ch == ' ')
			++whitecount;
		else if(ch == '\n')
			++newcount;
		else
			++othercount;
		ch = getchar();
	}
	printf("Whitespace Count: %d\n", whitecount);
	printf("Newline Count: %d\n", newcount);
	printf("Other Character Count: %d\n", othercount);

	return 0;
}
