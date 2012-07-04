/* prog2.c -- based off listing 8.8, p.297 */
/* demonstrate how to make and use a menu */

#include <stdio.h>
char get_choice(void);
char get_first(void);
int get_int(void);
void count(void);

int main(void)					// function main
{
	int choice;
	void count(void);			// call function count

	while((choice = get_choice()) != 'q')
	{
		switch(choice)
		{
			case 'a':
				printf("Buy low, sell high.\n");
				break;
			case 'b': 
				putchar('\a');
				break;
			case 'c':
				count();
				break;
			default:
				printf("Program error!\n");
				break;
		}
	}
	printf("Bye.\n");

	return 0;
}

void count(void)				// function count
{
	int n, i;

	printf("Count how far? Enter an integer:\n");
	n = get_int();				// call function get_int
	for(i = 1; i <= n; i++)
		printf("%d\n", i);
	while(getchar() != '\n')
		continue;

	return;
}

char get_choice(void)				// function get_choice
{
	int ch;

	printf("Enter the letter of your choice:\n");
	printf("a. advice	b. bell\n");
	printf("c. count	q. quit\n");
	ch = get_first();			// call function get_first
	while((ch < 'a' || ch > 'c') && ch != 'q')
	{
		printf("Please respond with a, b, c, or q.\n");
		ch = get_first();
	}

	return ch;
}

char get_first(void)				// function get_first
{
	int ch;

	ch = getchar();
	if(ch != '\n')
		while(getchar() != '\n')
			continue;

	return ch;
}

int get_int(void)				// function get_int
{
	int input;
	char ch;

	while(scanf("%d", &input) != 1)
	{
		while((ch = getchar()) != '\n')
			putchar(ch);
		printf(" is not an integer.\n");
		printf("Please enter an integer value, such as 25, -178, or 3: ");
	}

	return input;
}
