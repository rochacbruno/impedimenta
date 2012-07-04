/* prog5.c */

#include <stdio.h>

int main(void)
{
	char response;
	int guess = 0;

	printf("Pick a number. I bet I can guess it!\n");
	printf("Is the number %d(y or n)?\n", guess++);
	while((response = getchar()) != 'y')
	{
		if(response == 'n')
			printf("Well, is the number %d(y or n)?\n", guess++);
		else
			printf("Sorry, I only understand y and n.\n");
		if(response != '\n')
		{
			while(getchar() != '\n')
				continue;
		}
	}
	printf("I knew I could do it!\n");

	return 0;
}
