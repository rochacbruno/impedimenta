#include <iostream>
#include <math.h>
#include "studentdefs.h"
using namespace std;

/*-----------------------------------------------------------------------------/
Start class member function definitions
/-----------------------------------------------------------------------------*/
void DefaultStudentSetup::initializeGrades(void) {
	quiz1 = -1;
	quiz2 = -1;
	midterm = -1;
	final = -1;
	averageGrade = -1.0;

	return;
}

void DefaultStudentSetup::setGrades(void) {
	cout << "Enter a grade between 0 and 10 for quiz 1: ";
	while(!(cin >> quiz1) || quiz1 < 0 || quiz1 > 10) {
		cout << "Oops! You can only use numbers between 0 and 10, inclusive.\n"
		     << "Enter a grade between 0 and 10 for quiz 1: ";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');

	cout << "Enter a grade between 0 and 10 for quiz 2: ";
	while(!(cin >> quiz2) || quiz2 < 0 || quiz2 > 10) {
		cout << "Oops! You can only use numbers between 0 and 10, inclusive.\n"
		     << "Enter a grade between 0 and 10 for quiz 2: ";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');

	cout << "Enter a grade between 0 and 100 for the midterm: ";
	while(!(cin >> midterm) || midterm < 0 || midterm > 100) {
		cout << "Oops! You can only use numbers between 0 and 100, inclusive.\n"
		     << "Enter a grade between 0 and 100 for the midterm: ";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');

	cout << "Enter a grade between 0 and 100 for the final: ";
	while(!(cin >> final) || final < 0 || final > 100) {
		cout << "Oops! You can only use numbers between 0 and 100, inclusive.\n"
		     << "Enter a grade between 0 and 100 for the final: ";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');

	cout.setf(ios::fixed);
	cout.precision(0);

	averageGrade = (((static_cast<double>(quiz1)*10.0 + static_cast<double>(quiz2)*10.0) / 2.0) * 0.25);
	// start by averaging just the quizzes. Are 25% of grade, thus n * 0.25
	averageGrade = averageGrade + (static_cast<double>(midterm) * 0.25);
	// midterm worth 25% of grade, thus n * 0.25
	averageGrade = averageGrade + (static_cast<double>(final) * 0.50);
	// then, add in the final. Worth 50% of grade.

	return;
}

void DefaultStudentSetup::viewGrades(void) {
	cout << "Quiz 1: " << quiz1 << endl;
	cout << "Quiz 2: " << quiz2 << endl;
	cout << "Midterm: " << midterm << endl;
	cout << "Final: " << final << endl;
	cout << "Average grade: " << floor(averageGrade + 0.5) << " "; //no endl

	if(averageGrade < 59.50) {
		cout << "F\n";
	} else if(averageGrade < 69.50) {
		cout << "D\n";
	} else if(averageGrade < 79.50) {
		cout << "C\n";
	} else if(averageGrade < 89.50) {
		cout << "B\n";
	} else {
		cout << "A\n";
	}

	return;
}
