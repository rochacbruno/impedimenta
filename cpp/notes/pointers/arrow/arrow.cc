#include <iostream>
#include "Record.h"
using namespace std;

int main(void) {
	Record someData;
	Record *p;
	p = new Record;

	someData.name = "Dick";
	someData.ssn = 1234567890;
	(*p).name = "Jane";
	p->ssn = 2345678901;

	cout << "someData.name == " << someData.name << endl;
	cout << "someData.ssn == " << someData.ssn << endl;
	cout << "(*p).name == " << (*p).name << endl;
	cout << "p->ssn == " << p->ssn << endl;

	cout << endl;
	cout << "Let's assign some new data to someData and p, and see what happens.\n";
	someData = *(new Record);
	delete p;
	p = new Record;
	cout << "someData.name == " << someData.name << endl;
	cout << "someData.ssn == " << someData.ssn << endl;
	cout << "(*p).name == " << (*p).name << endl;
	cout << "p->ssn == " << p->ssn << endl;

	cout << endl;
	cout << "The new operator creates a new object and returns the address of that object. Therefore, someData = *(new Record); creates a new object, copies its contents into someData, and leaves the nameless Record object kicking around! Be careful.\n";
}
