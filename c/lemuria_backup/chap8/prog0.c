#include <stdio.h>

int main(void)
{
	int hour = 12;
	int advance = 5;

	hour = ((hour - 1 + advance)/12) + 1;
	printf("%d\n", hour);

	return 0;
}
