/* prog8.c -- Jeremy Audet */
/*
ask for input;
scan for input;
while input is not #,
	if input is '!', 
		replace input with !!;
		increment sub_count;
	if input is '.',
		replace input with !;
		increment sub_count;
	scan for input;
	repeat;
print results;
END;
*/


#include <stdio.h>

int main(void)
{
	int subcount = 0;
	char ch;

	printf("Please enter some strings(# to quit).\n");
	while((ch = getchar()) != '#')
	{
		if(ch == '!')
		{
			putchar(ch);
			putchar(ch);
			++subcount;
		}
		else if(ch == '.')
		{
			putchar('!');
			++subcount;
		}
		else
			putchar(ch);
	}
	putchar(ch);
	putchar('\n');
	printf("Substitutions: %d.\n", subcount);

	return 0;
}
