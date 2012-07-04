/* prog1.c -- Jeremy Audet, Tue Sep 29 15:09:43 EDT 2009 */
/*
ask for input;
scan for an int;
ask for input;
scan for an int;
compare the first int to the second;
if the first is larger than the second, 
	print out the first and then the second;
else if the the first is smaller than the second, 
	print out the second and then the first;
else if they are equal, 
	print out a message saying that they are equal;
else (if for some weird, weird reason none of those cases are true),
	print out an error message;
END;
*/

#include <stdio.h>

int main(void)
{
	int num_1;
	int num_2;

	printf("Please enter the first number to be compared: ");
	scanf("%d", &num_1);						// num_1 Initialized
	printf("Please enter the second number to be compared: ");
	scanf("%d", &num_2);						// num_2 Initialized
	if(num_1 > num_2)
		printf("%d is larger.\n", num_1);
	else if(num_1 < num_2)
		printf("%d is larger.\n", num_2);
	else if(num_1 == num_2)
		printf("The numbers are of equal value.\n");
	else
		printf("What the heck did you just give me for input? I don't understand. None of my comparisons work.\n");

	return 0;
}
