/* prog12.c */
/*
tell the user to pick a number;
guess the number;
ask whether the guess was high, low, or correct;
while answer is not correct,
	guess the answer;
	ask whether the guess was high, low, or correct;
	repeat;
number has been found.
print out results;
END;
*/

#include <stdio.h>

int main(void)
{
	char ch, junk;
	float guess = 50;
	float last;
	float adjust = 25;

	printf("Pick a number between 0 and 100, and I'll guess it.\n");
	printf("Is the number %.0f high, low, or correct?\n", guess);
	ch = getchar();
	if(ch != '\n')
	{
		junk = getchar(); 
		while(junk != '\n')
			junk = getchar();
	}
	while(ch != 'c')
	{
		switch(ch)
		{
			case 'h':
			case 'H':{
				last = guess;
				guess -= adjust;
				adjust /= 2;
				break;
			}
			case 'l':
			case 'L':{
				last = guess;
				guess += adjust;
				adjust /= 2;
				break;
			}
			default: 
				printf("Sorry, I didn't understand that.\n");
		}
		if((guess - last) < 1 && (guess - last) > -1)
			break;
		printf("Is the number %.0f high, low, or correct?\n", guess);
		ch = getchar();
		if(ch != '\n')
		{
			junk = getchar();
			while(junk != '\n')
				junk = getchar();
		}
	}
	printf("The number is %.0f.\n", guess);

	return 0;
}
