/* prog4.c -- Jeremy Audet, Tue Oct  6 15:53:50 EDT 2009 */
/*
ask for string input;
scan a character;
while input is not #,
	if input is ' ',
		spacecount++;
	else if input is '\n',
		newcount++;
	else
		othercount++;
	scan for another character;
	repeat;
print out results;

END;
*/

#include <stdio.h>

int main(void)
{
	char ch;
	int spacecount = 0;
	int newcount = 0;
	int othercount = 0;

	printf("Please enter input (# to quit).\n");
	ch = getchar();
	while(ch != '#')
	{
		if(ch == ' ')
			++spacecount;
		else if(ch == '\n')
			++newcount;
		else
			++othercount;
		ch = getchar();
	}
	printf("Spaces: %d.\n", spacecount);
	printf("Newlines: %d.\n", newcount);
	printf("Other: %d.\n", othercount);

	return 0;
}

