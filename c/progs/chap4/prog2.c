// prog2.c -- Uses several strings, then analyzes them.
#include <stdio.h>
#include <string.h>
#define PRAISE "What a super marvelous name!"

int main(void)
{
	char name[40];

	printf("What's your name?\n");
	scanf("%s", name);

	printf("Hello, %s. %s\n",
		name, PRAISE);
	printf("Your name of %lu letters occupies %lu memory cells (bytes?).\n",
		strlen(name), sizeof name);
	printf("PRAISE has %lu letters and occupies %lu memory cells (again, bytes?)\n",
		strlen(PRAISE), sizeof PRAISE);

	return 0;
}
