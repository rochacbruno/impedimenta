/* prog1.c -- Jeremy Audet. Listing 14.2 on p. 541 */
/* inventory books */

#include <stdio.h>
#define MAXTITL 41		// title name field length, including \0
#define MAXAUTL 41		// title name field length, including \0
#define MAXCOURSEREQ 21		// course requirement field length, including \0
#define MAXBKS 20		// max number of books too keep track of

struct book {
	char title[MAXTITL];
	char author[MAXAUTL];
	char coursereq[MAXCOURSEREQ];
	float price;
};

int main(void)
{
	struct book library[MAXBKS];
	int book = 0;
	int letter = 0;
	int current;
	char ch;

	printf("Please enter a title for book %d ([enter] to quit):\n", book + 1);
	while((ch = getchar()) != '\n')
		library[book].title[letter++] = ch;
	library[book].title[letter] = '\0';
	letter = 0;
	while((library[book].title[letter] != '\0') && (book < MAXBKS))
	{
		printf("Please enter an author for book %d:\n", book + 1);
		letter = 0;
		while((ch = getchar()) != '\n')
			library[book].author[letter++] = ch;
		library[book].author[letter] = '\0';
//----
		printf("Please enter a course synonym for book %d:\n", book + 1);
		letter = 0;
		while((ch = getchar()) != '\n')
			library[book].coursereq[letter++] = ch;
		library[book].coursereq[letter] = '\0';
//----
		printf("Please enter a price for book %d:\n", book + 1);
		while(scanf("%f", &library[book].price) != 1)
		{
			while(getchar() != '\n')
				continue;
			puts("Price entered was not valid, please try again.");
		}
		while(getchar() != '\n')
			continue;
//----
		if(++book < MAXBKS)
		{
			printf("Please enter a title for book %d ([enter] to quit):\n", book + 1);
			letter = 0;
			while((ch = getchar()) != '\n')
				library[book].title[letter++] = ch;
			library[book].title[letter] = '\0';
		}
		else
			library[book].title[0] = '\0';
		letter = 0;
	}
	if(book > 0)		// Has the user entered any books into the library?
	{
		puts("Here is a list of your books:");
		for(current = 0; current < book; current++)
			printf("%d) %s by %s: $%.2f (%s)\n", current + 1, library[current].title, library[current].author, library[current].price, library[current].coursereq);
	}
	else
		puts("No books? Too bad.");

	return 0;
}
