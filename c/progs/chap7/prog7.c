/* prog7.c -- Jeremy Audet */
/*
ask for input integers;
scan for input;
while input is not 0,
	if input is even,
		increment even int count;
		add int to even int sum;
	else
		increment odd int count;
		add int so odd int sum;
	repeat;
average even ints;
average odd ints;
print out results;
END;
*/


#include <stdio.h>

int main(void)
{
	int num = 1;
	int even_count = 0;
	int odd_count = 0;
	int even_sum = 0;
	int odd_sum = 0;

	printf("Please enter integers(0 to quit):\n");
	scanf("%d", &num);
	while(num != 0) 	
	{
		if((num % 2) == 0)		// If input is even int
		{
			even_sum += num;
			++even_count;
		}
		else
		{
			odd_sum += num;
			++odd_count;
		}
	scanf("%d", &num);
	}

	even_sum = even_sum / even_count;	// even_sum is now average of even numbers
	odd_sum = odd_sum / odd_count;		// odd_sum is now average of odd numbers
	printf("You input %d even numbers.\n", even_count);
	printf("The average of the even numbers is %d.\n", even_sum);
	printf("You input %d odd numbers.\n", odd_count);
	printf("The average of the odd numbers is %d.\n", odd_sum);

	return 0;
}
