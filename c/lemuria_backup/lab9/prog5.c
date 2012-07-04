/* prog5.c -- Jeremy Audet, Tue Oct 27 16:50:11 EDT 2009 */

#include <stdio.h>
void copy1(char *s1, char *s2);
void copy2(char *s1, char *s2);

int main(void)
{
	char string1[10];
	char *string2 = "Hello";
	char string3[10];
	char string4[] = "Good Bye";

	copy1(string1, string2);
	copy2(string3, string4);
	printf("string 1: %s\n", string1);
	printf("string 3: %s\n", string3);

	return 0;
}

void copy1(char *s1, char *s2)
{
	int i;
	for(i = 0; (s1[i] = s2[i]) != '\0'; i++)
		;
	printf("string1: %s\n", s1);
	printf("string2: %s\n", s2);
}

void copy2(char *s1, char *s2)
{
	for(; (*s1 = *s2) != '\0'; s1++, s2++)
		;
	printf("string3: %s\n", s1);
	printf("string4: %s\n", s2);
	printf("*s2 = %s\n", *s2);
}
