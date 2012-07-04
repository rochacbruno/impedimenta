/* prog1.c -- raise number n to power p */
#include <stdio.h>

int main(void)
{
	float num;						// num stores variable to be raised
	float num_orig;						// num_orig stores a copy of num before num has been raised. Useful in the raising operation
	int power;						// power stores the power that n will be raised to
	int count;						// count stores the current power that n has been raised to

	printf("Please input a number to be raised: ");
	scanf("%f", &num);					// Initialize num
	printf("Please enter a positive power to raise with: ");
	scanf("%d", &power);					// Initialize power

	num_orig = num;						// Initialize num_orig
	for(count = 1; count < power; count++)			// Initialize count
		num *= num_orig;
	printf("power: %d\n", power);
	printf("count: %d\n", count);
	printf("num_orig: %.2f\n", num_orig);
	printf("num: %.2f\n", num);

	return 0;
}
