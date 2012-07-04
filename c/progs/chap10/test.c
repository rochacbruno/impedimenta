#include <stdio.h>

void beep_noise(void);

int main(void)
{
	char string[10];

	printf("Test string should be printed below.\n");
	beep_noise();
	printf("\07");
	printf("Please enter a very short string:\n");
	scanf("%s", string);
	printf("String: %s\n", string);

	return 0;
}

void beep_noise(void)
{
	printf("I am the test string\n");
	printf("\07");
}
