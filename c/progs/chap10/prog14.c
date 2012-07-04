/* prog14.c -- test using sizeof() on array sizes */

#include <stdio.h>

void sizeof_test(char arr_label[], char * ptr);

int main(void)
{
	char char_array[20];
	char * pointer = &char_array[0];

	printf("Finding size of char_array and pointer within main()\n");
	printf("sizeof(char_array): %lu\n", sizeof(char_array));
	printf("sizeof(pointer):    %lu\n", sizeof(pointer));
	printf("Passing char_array as an argument.\n");
	sizeof_test(char_array, char_array);
	printf("Passing pointer as an argument.\n");
	sizeof_test(pointer, pointer);

	return 0;
}

void sizeof_test(char arr_label[], char * ptr)
{
	printf("sizeof(arr_label):  %lu\n", sizeof(arr_label));
	printf("sizeof(ptr):        %lu\n", sizeof(ptr));
}
