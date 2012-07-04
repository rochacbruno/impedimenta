/* prog12.c -- Jeremy Audet. Declare an array of pointers. Then make thoes pointers point to arrays. */

#include <stdio.h>

int main(void)
{
	char * pChar[2];
	char pName1[20] = {"John"};
	char pName2[20] = {"Rita"};
/* Init1: There are two objects, sequentially. They are type pointer-to-char. There is a pointer pointing to the first object, with the name pChar*/
/* Init2: There are 20 objects, sequentially. They are type char. There is a pointer called pName1, pointing to the first object*/

	pChar[0] = &pName1[0];
	pChar[1] = pName2;
	printf("pName1: %s\n", pChar[0]);
	printf("pName2: %s\n", *(pChar + 1));

/* pChar identifies an array. pChar is a constant pointer, and it holds the address of its first member -- a pointer. In this printf statement, I do not need the address of pChar's first member, I need what is held inside the first member of the array pChar. */
	printf("pName2, cut: %s\n", *(pChar + 1) + 1);
	printf("pName2, second letter: %c\n", *(*(pChar + 1) + 1));
	printf("pName2, second letter: %c\n", pName2[1]);

	return 0;
}
