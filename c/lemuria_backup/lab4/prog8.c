/* prog8.c -- problem 8 on lab 4, listing 7.12 on page 257 */
/* read a character, use switch to go to one of MULTIPLE! statements and increment vowel viewing count by one, then break and show you stats */
#include <stdio.h>

int main(void)
{
	char ch;
	int a_ct, e_ct, i_ct, o_ct, u_ct;

	a_ct = e_ct = i_ct = o_ct = u_ct = 0;

	printf("Enter some text; enter # to quit.\n");
	while ((ch = getchar()) != '#')
	{
		switch (ch)
		{
			case 'a' :
			case 'A' :
				a_ct++;
				break;
			case 'e' :
			case 'E' :
				e_ct++;
				break;
			case 'i' :
			case 'I' :
				i_ct++;
				break;
			case 'o' :
			case 'O' :
				o_ct++;
				break;
			case 'u' :
			case 'U' :
				u_ct++;
				break;
			default :
				break;
		}
	}
	printf("number of vowels used\n");
	printf("A: %d E: %d I: %d O: %d U: %d\n", a_ct, e_ct, i_ct, o_ct, u_ct);

	return 0;
}
