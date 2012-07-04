/* prog9.c -- prints out the letters a through g */
#include <stdio.h>

int main(void)
{
	char char1;
	char1 = '\97';
	char char2;
	char2 = '\x67';

	while(char1 < char2)
	{
		char1 = char1 + 1;
		printf("%5c", char1);
	}
	printf("\n");

	return 0;
}
