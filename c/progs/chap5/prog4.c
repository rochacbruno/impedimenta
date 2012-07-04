/* prog4.c -- review problem 3, chap 5 review, p. 167 */
/* scan int representing days; print out days in week, day format; while user still has input, scan and print again; quit when num<=0 is entered */
#include <stdio.h>

int main(void)
{
	int num = 0;

	printf("Please enter the number of days (0 to quit): ");
	scanf("%d", &num);
	while(num > 0)
	{
		printf("%d days is %d weeks and %d days.\n", num, num / 7, num % 7);
		printf("Please enter the number of days (0 to quit): ");
		scanf("%d", &num);
	}

	return 0;
}
