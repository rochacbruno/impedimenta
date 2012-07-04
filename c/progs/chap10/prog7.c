/* prog7.c -- declare an array using pointer notation, in several different ways */

#include <stdio.h>

int main(void)
{
	int Num;
	char pChars[] = {"abcde"};
	char * pChars2 = {"fghij"};
	char * pChars3 = pChars;
	char * pChars4 = pChars2;
	char * pChars5[] = {"wtfit"};
	char * pChars6[] = {	"Did I justtttt",
				"Creat an",
				"Array",
				"Of",
				"Arrays?"};
/*	char * pChar7 = {
				"one",
				"two",
				"three",
			}*/ //Invalid construct; too many members. Definition only creates a single array.
/*	char pChar8[] = {	"One beer!",
				"Two beers!",
				"Three beers!",
				"Boring."};*/ //Invalid construct; too many members. Definition only creates a single array.
/*	char ** pChar9 = {	"I think this",
				"definition and the",
				"next definition are",
				"the same."};*/ //NO, DAMMIT, too many members in initialization again.
// There are two sets of pointers in the above statement.
// The first set of pointers includes only one pointer. It holds the address of a particular pointer in the second set of pointers.
// The second set of pointers includes four pointers; one for each individual array/string.
// The first pointer of the second set holds, by default, the first member of the first array.
// The second pointer of the second set holds, by default, the first member of the second array.
// The third pointer of the second set holds, by default, the first member of the third array.
// And so on. Only once more. Because there's only four members in the second set of pointers.
/*	char pChar10[][] = {	"amiright?",
				"am I right?",
				"AM",
				"I",
				"CORRECT?"};*/ //ALSO WRONG. But why?

	printf("pChars:   %s\n", pChars);
	printf("pChars2:  %s\n", pChars2);
	printf("pChars3:  %s (pChars3 = pChars)\n", pChars3);
	printf("pChars4:  %s (pChars4 = pChars2)\n", pChars4);
	printf("*pChars5: %s\n", *pChars5);
	printf("*pChars6: %s\n", *pChars6);
	printf("pChars6:  %p\n", pChars6);
	puts("Contents of pChar6:");
	for(Num = 0; Num < 5; Num++)
		printf("%s\n", *(pChars6 + Num));	
//----wheee, more facts
	printf("\nsizeof(pChars) == %lu\n", sizeof(pChars));
	printf("sizeof(pChars2) == %lu\n", sizeof(pChars2));
	printf("sizeof(pChars3) == %lu\n", sizeof(pChars3));
	printf("sizeof(pChars4) == %lu\n", sizeof(pChars4));
	printf("sizeof(pChars5) == %lu\n", sizeof(pChars5));
	printf("sizeof(pChars6) == %lu\n", sizeof(pChars6));

	return 0;
}
