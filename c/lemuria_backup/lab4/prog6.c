/* prog6.c -- listing 7.10 on page 252 for lab 4 */
/* Uses a break statement to break out of a while loop. The while loop breaks when it comes across a non-numerical character. */
#include <stdio.h>

int main(void)
{
	float length = 0, width = 0;

	printf("Enter the length of the rectangle:\n");
	while (scanf("%f", &length) == 1)
	{
		printf("Length = %0.2f:\n", length);
		printf("Enter its width:\n");
		if (scanf("%f", &width) != 1)
		{
			break;
		}
		printf("Width = %0.2f:\n", width);
		printf("Area = %0.2f:\n", width * length);
		printf("Enter the length of the rectangle:\n");
	}
	printf("Done.\n");

	return 0;
}
		
