/* prog6.c -- Jeremy Audet */
/*
set num to 1;
if num <= 11,
	if num is divisible by 3, 
		print $;
	if num is not divisible by 3
		print *;
	print #;
	print %;
	repeat;
print newline;
END;
*/


#include <stdio.h>

int main(void)
{
	int num;

	for(num = 1; num <= 11; num++)
	{
		if((num % 3) == 0)
			putchar('$');
		else
			putchar('*');
		putchar('#');
		putchar('%');
		putchar('\n');
	}

	return 0;
}
