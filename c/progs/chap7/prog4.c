/* prog4.c -- Jeremy Audet, Tue Sep 29 22:01:45 EDT 2009 */
	/*
ask for input;
scan for input, assign value to height;
ask for input;
scan for input, assign value to weight;
if weight < 100 && height > 64
	if height > 74
		print you are very tall for your weight
	else
		print you are tall for your weight
if weight > 300 && height < 48
	print you are very short for your weight
else 
	print your bmi is acceptable
*/

#include <stdio.h>

int main(void)
{
	int height, weight;

	printf("Please enter a height and weight.\n");
	scanf("%d%d", &height, &weight);
	if(weight < 100 && height > 64)
	{
		if (height > 74)
			printf("You are very tall for your weight.\n");
		else
			printf("You are tall for your weight.\n");
	}
	else if(weight > 300 && height < 46)
		printf("You are short for your weight.\n");
	else
		printf("Your bmi is acceptable.\n");

	return 0;
}
