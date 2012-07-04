/* prog9.c -- Jeremy Audet */
/*
ask for input strings;
scan for input character;
while input character is not #,
	if input is i && flag is 1,
		increment eicount;
	set flag to 0;
	if input is e,
		set flag to 1;
	scan for input;
	repeat;
print number of times ei occurred;
END;
*/


#include <stdio.h>

int main(void)
{
	int flag = 0;
	int eicount = 0;
	char ch;

	printf("Please enter input(# to quit).\n");
	while((ch = getchar()) != '#')
	{
		if(ch == 'i' && flag == 1)
			++eicount;
		flag = 0;
		if(ch == 'e')
			flag = 	1;
	}
	printf("The character sequence \"ei\" occurred %d times.\n", eicount);

	return 0;
}
