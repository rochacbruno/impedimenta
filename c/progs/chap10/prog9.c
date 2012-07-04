/* prog9.c -- derived from listing 10.15, on page 379 */

#include <stdio.h>

int main(void)
{
	int zippo[4][2] = {	{2,4},
				{6,8},
				{1,3},
				{5,7}	};

	puts("From the declaration: int zippo[4][2] = {etc};");
	putchar('\n');
	printf("    zippo = %p,    zippo + 1 = %p\n", zippo, zippo + 1);
	printf(" zippo[0] = %p, zippo[0] + 1 = %p, zippo[1] = %p\n", zippo[0], zippo[0] + 1, zippo[1]);
	printf("   *zippo = %p,   *zippo + 1 = %p\n", *zippo, *zippo + 1);
	printf("&zippo[0] = %p, &zippo[0][0] = %p\n", &zippo[0], &zippo[0][0]);
	putchar('\n');
	printf("zippo[0] = %p, sizeof(zippo[0]) = %lu\n", zippo[0], sizeof(zippo[0]));
	printf("  *zippo = %p,   sizeof(*zippo) = %lu\n", *zippo, sizeof(*zippo));
	printf("   zippo = %p,    sizeof(zippo) = %lu\n", zippo, sizeof(zippo));
	putchar('\n');
	printf("zippo[0][0] = %d\n", zippo[0][0]);
	printf("  *zippo[0] = %d\n", *zippo[0]);
	printf("    **zippo = %d\n", **zippo);
	printf("        zippo[2][1] = %d\n", zippo[2][1]);
	printf("*(*(zippo + 2) + 1) = %d\n", *(*(zippo + 2) + 1));
	putchar('\n');
	puts("Line 2: zippo[0] holds the address of the first member of a two-int object.");
	puts("Therefore, while zippo[0] + 1 is the second member of that same two-int object,");
	puts("zippo[1] is the first member of the next two-int object.");
	putchar('\n');
	puts("Note that when incrementing a pointer in an array, one increments by what that");
	puts("that pointer consists of. For example, contrast line 1 and 2. zippo holds the");
	puts("address of a two-int object, while zippo[0] holds the address of a single int.");
	puts("Incrementing zippo adds however many bytes comprise a two-int object.");
	puts("Incrementing zippo[0] adds however many bytes comprise an int object.");

	return 0;
}
