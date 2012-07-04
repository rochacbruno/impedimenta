/* prog4.c -- Jeremy Audet */
/*
display a number;
ask whether to continue and print another number;
while user asks to continue,
	print next number;
	ask whether to continue;
	repeat;
say goodbye;
END;

why doesn't it work? I don't understand?
*/

#include <stdio.h>

int main(void)
{
	int num = 0;
	char response;

	printf("Would you like me to start counting(yes or no)?\n");
	while((response = getchar()) == 'y');
	{
		printf("%d\n", num++);
		if(response != '\n')
		{
			while(getchar() != '\n')
				continue;
		}
		printf("Would you like me to continue(yes or no)?\n");
	}
	printf("Thank you for using the number counting service.\n");

	return 0;
}
