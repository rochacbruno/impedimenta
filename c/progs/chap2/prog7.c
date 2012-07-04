#include <stdio.h>
void line3(void);
int line4(void);

int main(void)
{
	printf("For he's a jolly good fellow!\n");
	printf("For he's a jolly good fellow!\n");
	line3();
	line4();

	return 0;
}

void line3(void)
{
	printf("For he's a jolly good fellow!\n");
}

int line4(void)
{
	printf("Which nobody can deny!\n");

	return 0;
}
