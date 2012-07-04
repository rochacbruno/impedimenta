/*=============================================================================/
This program allows a user to enter a series of grades and get a bar graph for output. The user will first enter a number that describes the highest grade possible. The user will then enter grades until a negative number is entered. Once all grades are entered, the program will output a histogram that shows all users' grades, one at a time. The program will store grades in a vector, and allow the user to scroll through the resultant graph, one entry at a time. Coolio. Sample snapshot of program:
========================================
What is the highest grade possible for this assignment: 50
Start entering grades for students. Once you are done, enter a negative grade.
45
12
50
51
51 is larger than the maximum grade of 50. Try again: 25
20
-1
Press enter to scroll through the graph of grades.
45  [*******************************************************************       ]
12  [******************                                                        ]
50  [**************************************************************************]
25  [*************************************                                     ]

========================================
And so on and so forth. You get the idea. The graph shown assumes that you are using a terminal 80 characters wide. It cannot detect or resize to accomodate different terminal widths.

In the example above:
maxLength = 74;
grade = 45;	// anything from 0 to 50
maxGrade = 50;
barLength = 0;	// initially. This is being calculated

The idea is this: barLength / maxLength = grade / maxGrade, where barLength is being calculated. 
When this fraction is shuffled around a bit, you get barLength = (maxLength * grade) / maxGrade;
In order to account for fractional results, this is added:
if((maxLength * grade) % maxGrade >= maxGrade / 2) {
	++barLength;
}
Thus, in the example above, if the remainder of the barLength calculation is greater than or equal to 25, the bar would have a star added to it.
/=============================================================================*/
#include <iostream>
#include <vector>
#include "gradesUtilities.h"
using namespace std;

int main(void) {
	int maxLength = 74;
	int newGrade = 0;
	int maxGrade = 0;
	int barLength = 0;
	int i = 0;
	bool repeatLoop = false;
	vector<int> grades;

	/*=====================================================================/
	Only repeats loop if there is an error getting input.
	Variations on this method of handling input will be repeated throughout the program, so make sure you understand how this works.
	/=====================================================================*/
	do {
		cout << "Enter the highest grade possible for this assignment: ";
		if(false == (cin >> maxGrade)) {
			repeatLoop = true;
			cin.clear();

			cout << endl
			     << "I need a number like 100 or 86."
			     << endl;
		} else if(maxGrade <= 0) {
			repeatLoop = true;
			cout << endl
			     << "The maximum grade needs to be 1 or greater! "
			     << maxGrade
			     << " won't work.\n";
		} else {
			repeatLoop = false;
		}
		cin.ignore(1000, '\n');
	} while(true == repeatLoop);
	cout << endl;

	/*=====================================================================/
	This loop allows the user to enter grades.
	/=====================================================================*/
	cout << "Start entering grades for students. Once you are done, enter a negative grade." << endl;
	do {
		if(false == (cin >> newGrade)) {
			repeatLoop = true;
			cout << "I need a whole number like 12 for a grade, not a letter or symbol. Try again.\n";
			cin.clear();
		} else if(newGrade > maxGrade) {
			repeatLoop = true;
			cout << newGrade
			     << " is greater than the maximum possible grade of "
			     << maxGrade
			     << ". Try again.\n";
		} else if(newGrade < 0) {
			repeatLoop = false;
		} else {
			repeatLoop = true;
			grades.push_back(0);
			grades[grades.size() - 1] = newGrade;
		}
		// always clear input buffer after grabbing something from user
		cin.ignore(1000,'\n');
	} while(true == repeatLoop);

	/*=====================================================================/
	This loop allows the user to view bar graphs.
	/=====================================================================*/
	cout << endl
	     << "Press enter to scroll through the graph of grades.\n";
	for(i = 0; i < grades.size(); i++) {
		barLength = (maxLength * grades[i]) / maxGrade;
		if((maxLength * grades[i]) % maxGrade >= maxGrade / 2) {
			++barLength;
		}

		Utilities::printNumber(grades[i]);
		cout << "[";
		Utilities::printStars(barLength);
		cout << "]";

		cin;
		cin.ignore(1000,'\n');
	}

	return 0;
}
