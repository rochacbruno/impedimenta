/* prog7.c -- review question 2, page 212, chapter 6 */
/* declare int value = 0; if value > 0 then divide int by 21 and set value to answer (dropping the remainder, of course); print value out and repeat; end */
#include <stdio.h>

int main(void)
{
	int value = 0;

	printf("%d\n", value);
	for(value = 36; value > 0; value /= 21)
		printf("%d\n", value);

	return 0;
}
