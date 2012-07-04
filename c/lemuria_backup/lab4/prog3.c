/* prog3.c -- problem 3 for lab 04. Uses a while loop to add and average a set of numbers. */
#include <stdio.h>
const int FREEZING = 0;

int main(void)
{
	float temperature = 0;
	int cold_days = 0;
	int all_days = 0;

	printf("Enter the list of daily low temperatures.\n");
	printf("Use Celsius, and enter q to quit.\n");
	while (scanf("%f", &temperature) == 1)
	{
		all_days++;
		if (temperature < FREEZING)
			cold_days++;
	}
	if (all_days != 0)
		printf("%d days total: %.1f%% were below freezing.\n",
			all_days, 100.0 * (float) cold_days / all_days);
	if (all_days == 0)
		printf("No data entered!\n");

	return 0;
}
