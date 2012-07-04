#include <iostream>
#include "classmonthdef.h"
using namespace std;

int main(void) {
	Month myMonth1;
	Month myMonth2(4);
	Month myMonth3('m', 'a', 'y');
	char ch1, ch2, ch3;

	cout << "myMonth1.getMonthInt(): "
	     << myMonth1.getMonthInt()
	     << endl
	     << "myMonth2.getMonthInt(): "
	     << myMonth2.getMonthInt()
	     << endl
	     << "myMonth3.getMonthInt(): "
	     << myMonth3.getMonthInt()
	     << endl;

	myMonth1.getMonthChar(ch1, ch2, ch3);
	cout << "myMonth1.getMonthChar(): "
	     << ch1 << ch2 << ch3
	     << endl;
	myMonth2.getMonthChar(ch1, ch2, ch3);
	cout << "myMonth2.getMonthChar(): "
	     << ch1 << ch2 << ch3
	     << endl;
	myMonth3.getMonthChar(ch1, ch2, ch3);
	cout << "myMonth3.getMonthChar(): "
	     << ch1 << ch2 << ch3
	     << endl;;
	

	return 0;
}
