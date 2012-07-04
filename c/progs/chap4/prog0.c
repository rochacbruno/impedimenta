// talkback.c -- nosy, informative program
#include <stdio.h>
#include <string.h> //For strlen() prototype
#define DENSITY 62.4 //Human density in lbs per cu ft

int main(void)
{
	float weight, volume;
	int size, letters;
	char name[40]; //name is an array of 40 characters

	printf("Hi! What's your first name?\n");
	scanf("%s", name);
	printf("%s, what's your weight in pounds?\n", name);
	scanf("%f", &weight);

	size = sizeof name; // Measure size of array, irrespective of what is stored in it.
	letters = strlen(name); // Measure number of letters stored in array, irrespective of total length of array.
	volume = weight / DENSITY; // need ft^3, have lbs/ft^3, simply divide lbs by lbs/ft^3

	printf("Well, %s, your volume is %2.2f cubic feet.\n",
		name, volume);
	printf("Your first name has %d letters in it.\n",
		letters);
	printf("And we have %d bytes to store it in!\n",
		size);

	return 0;
}
