/*-============================================================================/
This file implements all of the member functions of class DynamicStringArray.

Here's a condensed repeat of DynamicStringArray:
class DynamicStringArray {
	public:
		int getSize(void) const;
		void addEntry(string);
		string getEntry(int) const;
		bool deleteEntry(string);

		DynamicStringArray();
		~DynamicStringArray();
		DynamicStringArray(const DynamicStringArray&);
		DynamicStringArray operator =(const DynamicStringArray&);
	private:
		int size;
		string *ptrString;
};
/============================================================================-*/

#include "DynamicStringArray.h"
#include <iostream>
using std::cout;
using std::endl;

/*-====================================/
DynamicStringArray::getSize()
Simple getter that returns size.
/====================================-*/
int DynamicStringArray::getSize(void) const {
	return size;
}

/*-====================================/
DynamicStringArray::addEntry()
Add an entry to ptrString.
/====================================-*/
void DynamicStringArray::addEntry(string newString) {
	int i = 0;
	string *ptrNewString = NULL;

	ptrNewString = new string[size + 1];
	for(i = 0; i < size; ++i) {
		ptrNewString[i] = ptrString[i];
	}
	ptrNewString[i] = newString;

	delete [] ptrString;
	ptrString = ptrNewString;
	++size;

	return;
}

/*-====================================/
DynamicStringArray::getEntry()
Find an entry in ptrString, given an index number.
/====================================-*/
string DynamicStringArray::getEntry(int index) const {
	if(index < size) {
		return ptrString[index];
	} else {
		return "";
	}
}

/*-====================================/
DynamicStringArray::deleteEntry()
Delete an entry in ptrString, if a match to the argument is found.
/====================================-*/
bool DynamicStringArray::deleteEntry(string delString) {
	int i = 0;
	int target = -1;
	bool matchFound = false;
	string *ptrNewString = NULL;

	// check to see if the string passed is present
	for(i = 0; i < size && false == matchFound; ++i) {
		if(delString == ptrString[i]) {
			matchFound = true;
			target = i;
		}
	}

	// if string passed is present in ptrString, delete that element
	if(true == matchFound) {
		// create a new array one element smaller than the current one
		ptrNewString = new string[size - 1];

		// copy old elements into new array
		for(i = 0; i < size && i != target; ++i) {
			ptrNewString[i] = ptrString[i];
		}
		++i;
		for(; i < size; ++i) {
			ptrNewString[i - 1] = ptrString[i];
		}

		// after copying old array into new array, delete old array
		delete [] ptrString;
		ptrString = ptrNewString;
		--size;
	}

	return matchFound;
}

/*-====================================/
DynamicStringArray::DynamicStringArray()
Constructor
/====================================-*/
DynamicStringArray::DynamicStringArray() {
	size = 0;
	ptrString = NULL;

	return;
}

/*-====================================/
DynamicStringArray::~DynamicStringArray()
Destructor
/====================================-*/
DynamicStringArray::~DynamicStringArray() {
	delete [] ptrString;
}

/*-====================================/
DynamicStringArray::DynamicStringArray()
Copy Constructor
/====================================-*/
DynamicStringArray::DynamicStringArray(const DynamicStringArray& oldObject) {
	size = oldObject.size;
	ptrString = new string[size];
	for(int i = 0; i < size; ++i) {
		ptrString[i] = oldObject.ptrString[i];
	}
}

/*-====================================/
DynamicStringArray DynamicStringArray::operator =()
Assignment Operator
/====================================-*/
DynamicStringArray DynamicStringArray::operator =(const DynamicStringArray& rightValue) {
	int i = 0;

	if(this == &rightValue) {
		return *this;
	} else {
		delete [] ptrString;

		size = rightValue.size;
		ptrString = new string[size];
		for(i = 0; i < size; ++i) {
			ptrString[i] = rightValue.ptrString[i];
		}
	}

	return *this;
}
