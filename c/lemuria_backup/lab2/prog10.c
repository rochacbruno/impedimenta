/* prog10.c -- exercise 9 on page 166. Prints out several numbers using while loops. */
#include <stdio.h>
int a(void);
int b(void);
int c(void);

int main(void)
{
	printf("Program a gives...\n");
	a();
	printf("Program b gives...\n");
	b();
	printf("Program c gives...\n");
	c();
	printf("And that is all!\n");

	return 0;
}

int a(void)
{
	int x = 0;

	while (++x < 3)
	{
		printf("%4d", x);
	}
	printf("\n");

	return 0;
}

int b(void)
{
	int y = 100;

	while (y++ <103)
	{
		printf("%4d\n", y);
		printf("%4d\n", y);
	}
	printf("\n");

	return 0;
}

int c(void)
{
	char char1 = 's';
	//char char2 = '\x77';

	while(char1 < 'w')
	{
		printf("%c", char1);
		char1 = char1 + 1;
	}
	printf("%c\n", char1);
	printf("\n");

	return 0;
}
