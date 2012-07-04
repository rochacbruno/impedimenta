/* prog7.c -- listing 7.11, page 253, lab 4. */
/* take a character for input, use the switch function to compare against several choices, print out choice if character comparison is valid, break 
when '#' is encountered. */
#include <stdio.h>
#include <ctype.h>

int main(void)
{
	char ch;

	printf("Give me a letter of the alphabet, and I will give ");
	printf("an animal name\nbeginning with that letter.\n");
	printf("Please type in a letter; type # to end my act.\n");
	while((ch = getchar()) != '#')
	{
		if ('\n' == ch)
			continue;
		if (islower(ch))
			switch (ch)
			{
				case 'a' :
					printf("argali, a whild sheep of Asia\n");
					break;
				case 'b' :
					printf("babirusa, a wildpig of Malay\n");
					break;
				case 'c' :
					printf("coati, racoonlike mammal\n");
					break;
				case 'd' :
					printf("desman, aquatic, molelike critter\n");
					break;
				case 'e' :
					printf("enchidna, the spiny anteater\n");
					break;
				case 'f' :
					printf("fisher, brownish marten\n");
					break;
				default :
					printf("That's a stumper!\n");
			}
		else 
			printf("I only recognize lowercase letters.\n");
		printf("Please type anotyher letter or a #.\n");
	}
	printf("Bye!\n");

	return 0;
}
