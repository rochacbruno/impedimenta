/* prog9.c -- Jeremy Audet */
/*
while there is still input,
	read a character;
	if input is a printable character,
		print out character and its integer representation;
	else if input is nonprinting character,
		print out letter representation and integer representation;
	else if input is newline,
		print out \n;
	else if input is tab,
		print out \t;
	else
		print out error message;
	every tenth character,
		start a newline;
	repeat;
END;
*/

#include <stdio.h>

int main(void)
{
	char ch;
	int count = 0;

	while((ch = getchar()) != EOF)
	{
		if(ch >= ' ' && ch <= '~')		// if input is printable
			printf(" %c == %3d   ", ch, ch);
		else if(ch == '\n')			// if input is a newline
			printf("\\n == %3d   ", ch);
		else if(ch == '\t')			// if input is a tab
			printf("\\t == %3d   ", ch);
		else if(ch >= 0 && ch <= 31)		// if input is not printable
			printf("^%c == %3d   ", (ch + 64), ch);
		else					// otherwise...
			printf("Wut?");
		if((++count % 10) == 0)
			putchar('\n');
	}

	return 0;
}
