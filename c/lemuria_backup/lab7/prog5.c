/* prog5.c -- Jeremy Audet, Tue Oct  6 16:04:22 EDT 2009 */
/*
ask for int age, int assets, and string pet;
scan for int age, whitespace, float assets, whitespace, string pet;
print out results;
END;
*/

#include <stdio.h>

int main(void)
{
	int age;
	float assets;
	char pet[30];

	printf("Enter your age, assets, and favorite pet.\n");
	scanf("%d %f", &age, &assets);
	scanf("%s", pet);
	printf("Age: %d\nAssets: %.2f\nPet: %s\n", age, assets, pet);

	return 0;
}
