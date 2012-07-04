/* prog4.c -- make a simple structure... and expand this program as I see fit */
/*
if month below has an earlier letter (smaller int representation), then
	copy current value into temp;
	copy month below into current cell;
	copy temp into month below;
do this MONTHS - 1 times;

for(num = 0; num < 11; num++)
	if(Month[num].Name[0] > Month[num + 1].Name[0])
	{
		copy current month into temp;
		copy month below into current month;
		copy temp into month below;
	}

strlen() might be useful when comparing Month.Name values
*/

#include <stdio.h>
#include <string.h>

struct monthdata {
	char Name[15];
	char Abbreviation[3];
	int Days;
	int MonthNumber;
};

int main(void)
{
	int num;
//	struct monthdata TempMonth;
	struct monthdata Month[12] = {	{"January",	"Jan",	31,	1},
					{"February",	"Feb",	28,	2},
					{"March", 	"Mar",	31,	3},
					{"April", 	"Apr",	30,	4},
					{"May", 	"May",	31,	5},
					{"June", 	"Jun",	30,	6},
					{"July", 	"Jul",	31,	7},
					{"August", 	"Aug",	31,	8},
					{"September", 	"Sep",	30,	9},
					{"October", 	"Oct",	31,	10},
					{"November", 	"Nov",	30,	11},
					{"December", 	"Dec",	31,	12}
	};

//	strcpy(Month[0].Name, "January");		How to assign a value to a string (incidentally, the string resides in a structure).
	puts("Month		Abbrev.	Days	Month No.");
	for(num = 0; num < 12; num++)
	{
		if(strlen(Month[num].Name) < 8)
			printf("%s		%s	%d	%d\n", Month[num].Name, Month[num].Abbreviation, Month[num].Days, Month[num].MonthNumber);
		else
			printf("%s	%s	%d	%d\n", Month[num].Name, Month[num].Abbreviation, Month[num].Days, Month[num].MonthNumber);
	}

	return 0;
}
