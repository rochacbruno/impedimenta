#include <stdio.h>
int main(void) //This program converts my age in YEARS to DAYS and displays both.

{
	int ageyears, agedays;

	ageyears = 18;
	agedays = 365 * ageyears;
	printf("As of the time of this writing, I am %d years old.\n", ageyears);
	printf("That is approximately equivalent to %d days.\n", agedays);

	return 0;
}
