/* prog11.c -- part of chap 3 review. see answers.txt. This program corrects a program given. */
#include <stdio.h>

int main(void)
{
	int cows = 0, legs = 0;

	printf("How many cow legs did you count?\n");
	scanf("%d", &legs); 
	cows = legs / 4;
	printf("That implies there are %d cows.\n", cows);

	return 0;
}
