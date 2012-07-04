/* prog10.c */
/* 
while there is still input,
	read a character;
	if character is uppercase,
		increment uppercount;
	else if character is lowercase,
		increment lowercase;
	else,
		continue;
print out results;
END;
*/

#include <stdio.h>
#include <ctype.h>

int main(void)
{
	int ch;
	int uppercount = 0;
	int lowercount = 0;

	while((ch = getchar()) != EOF)
	{
		if(isupper(ch))
			++uppercount;
		else if(islower(ch))
			++lowercount;
		else
			continue;
	}
printf("Upper case characters: %d.\n", uppercount);
printf("Lower case characters: %d.\n", lowercount);

	return 0;
}
