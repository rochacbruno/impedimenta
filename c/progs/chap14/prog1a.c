/* prog1.c -- Jeremy Audet. Listing 14.2 on p. 541 */
/* inventory books */

#include <stdio.h>
#define MAXTITL 21		// title name field length, including \0
#define MAXAUTL 21		// title name field length, including \0
#define MAXBKS 20		// max number of books too keep track of

struct book {
	char title[MAXTITL];
	char author[MAXAUTL];
	float value;
};

int main(void)
{
	struct book library[MAXBKS];
	int count = 0;
	int index;

	printf("Please enter the book title.\n");
	printf("Press [enter] at the start of a line to stop.\n");
	while((count < MAXBKS) && (gets(library[count].title) != NULL) && (library[count].title != '\0'))
	// will exit if (1) all books entries have been used (2) there is error scanning or (3) the value entered is [enter].
	{
		printf("Now enter the author.\n");
		gets(library[count].author);
		printf("Now enter the value.\n");
		scanf("%f", &library[count++].value);		// count is incremented
		while(getchar() != '\n')
			continue;
		if (count < MAXBKS)				// count has already been incremented
			puts("Enter the next title.");
	}

	if(count > 0)						// Has the user entered any books into the library?
	{
		puts("Here is a list of your books:");
		for(index = 0; index < count; index++)
			printf("%s by %s: $%.2f\n", library[index].title, library[index].author, library[index].value);
	}
	else
		puts("No books? Too bad.");

	return 0;
}
