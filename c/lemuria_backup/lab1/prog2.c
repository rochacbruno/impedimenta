/* This program uses several types of conversion specifiers. Conversion specifiers are special characters inserted into a function (such as the printf 
function) which are substituted for other values. */

#include <stdio.h>
#define PI 3.141593

int main(void)
{
	int ceos = 5;
	float espresso = 13.5;
	int cost = 3100;

	printf("The %d CEOs drank %2.2f cups of espresso.\n",
		ceos, espresso);
	printf("The value of pi is %f.\n",
		PI);
	printf("Farewell! Thou art too dear for my possessing,\n");
	printf("%c%d\n",
		'$', 2 * cost);

	return 0;
}
