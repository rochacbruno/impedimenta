/* prog4.c -- make a simple structure */

#include <stdio.h>
#include <string.h>

struct month {
	char Name[20];
	char Abbreviation[3];
	int Days;
	int MonthNumber;
};

int main(void)
{
	int num;
	struct month January = {"January", "Jan", 31, 1};
	struct month Year[12] = {
					{"January", "Jan", 31, 1},
					{"February", "Feb", 28, 2},
					{"March", "Mar", 31, 2},
					{"April", "Apr", 30, 2},
					{"May", "May", 31, 2},
					{"June", "Jun", 30, 2},
					{"July", "Jul", 31, 2},
					{"August", "Aug", 31, 2},
					{"September", "Sep", 30, 2},
					{"October", "Oct", 31, 2},
					{"November", "Nov", 30, 2},
					{"December", "Dec", 31, 2},
				};

	for(num = 0; num < 12; num++)
		Year[num].MonthNumber = num + 1;
	printf("Month	Abbrev	Days	MonthNum\n"
		"%s	%s	%d	%d\n\n", January.Name, January.Abbreviation, January.Days, January.MonthNumber);
	puts("Month           Abbrev  Days    MonthNum");
	for(num = 0; num < 12; num++)
	{
		if(strlen(Year[num].Name) <= 7)
			printf("%s		%s	%d	%d\n", Year[num].Name, Year[num].Abbreviation, Year[num].Days, Year[num].MonthNumber);
		else
			printf("%s	%s	%d	%d\n", Year[num].Name, Year[num].Abbreviation, Year[num].Days, Year[num].MonthNumber);
	}
//----Just a little test here. Note that sizeof() returns a long, unsigned int. Makes sense, given that sizeof() should never return a negative value (right?).
	printf("\nSize of struct January (type month), according to the sizeof() function\n"
		"sizeof(January) == %d\n", (int) sizeof(January));
	printf("Size of struct January (type month), according to the sizeof() function\n"
		"sizeof(January) == %lu\n", sizeof(January));

return 0;
}
