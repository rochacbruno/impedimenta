/* prog8.c -- answer to chap 4 review question 4. see answers.txt. correct the given program */
#include <stdio.h>
#define X 10
#define B "booboo"

int main(void)
{
	int age = 0, ageplus = 0;
	char name[40];

	printf("Please enter your first name: ");
	scanf("%s", name);
	printf("All right, %s, what's your age: ", name);
	scanf("%d", &age);
	ageplus = age + X;
	printf("That's a %s! You must be at least %d.\n", B, ageplus);

	return 0;
}
