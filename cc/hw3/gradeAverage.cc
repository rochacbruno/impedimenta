/*-----------------------------------------------------------------------------/
Jeremy Audet
Just for fun.
Allow someone to enter three grades into a student record. View and average the grades.
/-----------------------------------------------------------------------------*/
#include <iostream>
#include "studentdefs.h"
using namespace std;

int main(void) {
	DefaultStudentSetup someStudent;

	someStudent.initializeGrades();
	someStudent.viewGrades();
	someStudent.setGrades();
	someStudent.viewGrades();

	return 0;
}
