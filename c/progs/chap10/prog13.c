/* prog13.c -- make a program that will pick out the identifier in a given string. Make sure the program identifies where the beginning of the identifier is located, and how long the identifier is. Make the program print out the identifier. */
// Some Example Strings:
// int pants;
// int * pants;
// int pants[20];
// int * pants[20];
// int pants[20][5];
// int ** pants;
// int (* pants)[2];
// char **(**q)[ 30 ];
// int *(*(*(*b)())[10])();
// char *strprt( char (*)( int ), unsigned char );
// int (*const ab[])( unsigned int );
/*
How to pick out the identifier?
Here's some facts that are true about any identifier:
	Preceded ONLY by a certain set of keywords, asterisks, and left parentheses.
	Parentheses:
		int (**) pants; IS NOT valid
		int ** pants; IS valid
	Asterisks:
		Any number of asterisks is okay. Spaces may or may not be between asterisks and other characters.
		Asterisks may be "attached" to keywords such as volatile and const.
		Asterisks may be "attached" to left parentheses.
	Keywords:
		data-type keywords
			int
			long
			short
			unsigned
			char
			float
			double
			signed
			void
			_Bool
			_Complex
			_Imaginary
		storage class identifiers:
			extern
			volatile
			auto
			register
			maybe more?
*/

#include <stdio.h>

struct data_types {
	char type0[4];
	char type1[5];
	char type2[6];
	char type3[9];
	char type4[5];
	char type5[6];
	char type6[7];
	char type7[7];
	char type8[5];
	char type9[6];
	char type10[9];
	char type11[11];
};

int main(void)
{
	int num;
	struct data_types list = {
		"int",
		"long",
		"short",
		"unsigned",
		"char",
		"float",
		"double",
		"signed",
		"void",
		"_Bool",
		"_Complex",
		"_Imaginary",
	};

	return 0;
}
