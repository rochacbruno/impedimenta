/*-============================================================================/
Jeremy Audet
for Object Oriented Programming, by Michael Soulia

This program demonstrates the capabilities of the DynamicStringArray class. The DynamicStringArray class was described in practice problem 10.6. There are some differences between what was requested in the book and what I've implemented here. Most notably, the behaviour of getEntry has been changed. If an invalid string is passed to this function (say, you are requesting the string "Lowell" where none exists in that object), then getEntry will NOT return a NULL value. That is impossible. Rather, getEntry will return an exmpty string.

I've also created the eatMemory function, whose sole purpose is to create five million DynamicStringArray objects. Doing so will eat up about 150 megs of memory, at least on my machine. Funnily enough, after exiting eatMemory, that memory is not reclaimed. Again, this is machine-dependent. However, it still puzzles me. I believe exiting scope should destroy objects, not allow them to contine existing. It puzzles me.

Another cool little experiment is to comment out both the declaration of, and definition of, the overloaded assignment operator in class DynamicStringArray. Doing so will force the compiler to create its own assignment operator. This default assignment operator should only do a shallow copy of values, not a deep copy. It's interesting to see how a segmentation fault occurs at the end of this program. That's not the error I expected. I expected a shallow copy to occur, not a segmentation fault.
/============================================================================-*/
#include <iostream>
#include "DynamicStringArray.h"
using std::cin;
using std::cout;
using std::endl;

void eatMemory(void);

int main(void) {
/*	cout << "Before calling function.\n";
	cin;
	cin.ignore(1000,'\n');
	{
		eatMemory();
	}
	cout << "After returning from function.\n";
	cin;
	cin.ignore(1000,'\n');
*/

	DynamicStringArray someStrings;

	someStrings.addEntry("test1");
	someStrings.addEntry("test2");
	someStrings.addEntry("test3");
	someStrings.addEntry("test4");
	someStrings.addEntry("test5");

	cout << "--------------------------------------------------------------------------------\n";
	cout << "After deleting objects, getEntry responds gracefully to bad requests.\n";
	someStrings.deleteEntry("test2");
	someStrings.deleteEntry("test3");
	cout << "Size of someStrings object: " << someStrings.getSize() << endl;
	cout << "String 1: " << someStrings.getEntry(0) << endl;
	cout << "String 2: " << someStrings.getEntry(1) << endl;
	cout << "String 3: " << someStrings.getEntry(2) << endl;
	cout << "String 4: " << someStrings.getEntry(3) << endl;
	cout << "String 5: " << someStrings.getEntry(4) << endl;

	cout << "--------------------------------------------------------------------------------\n";
	cout << "deleteEntry also responds gracefully to bad requests. (deleteEntry(\"test2\"))\n";
	someStrings.deleteEntry("test2");
	cout << "String 1: " << someStrings.getEntry(0) << endl;
	cout << "String 2: " << someStrings.getEntry(1) << endl;
	cout << "String 3: " << someStrings.getEntry(2) << endl;
	cout << "String 4: " << someStrings.getEntry(3) << endl;
	cout << "String 5: " << someStrings.getEntry(4) << endl;
;
	cout << "--------------------------------------------------------------------------------\n";
	cout << "The copy constructor works correctly. (moreStrings(someStrings))\n";
	DynamicStringArray moreStrings(someStrings);
	cout << "Size of moreStrings object: " << moreStrings.getSize() << endl;
	cout << "String 1: " << moreStrings.getEntry(0) << endl;
	cout << "String 2: " << moreStrings.getEntry(1) << endl;
	cout << "String 3: " << moreStrings.getEntry(2) << endl;
	cout << "String 4: " << moreStrings.getEntry(3) << endl;
	cout << "String 5: " << moreStrings.getEntry(4) << endl;

	cout << "(Enter)\n> ";
	cin;
	cin.ignore(1000,'\n');

	cout << "--------------------------------------------------------------------------------\n";
	cout << "After some modifications, here's what moreStrings looks like.\n";
	moreStrings.deleteEntry("test1");
	moreStrings.deleteEntry("test4");
	moreStrings.deleteEntry("test5");
	moreStrings.addEntry("There once was a pauper named Meg");
	moreStrings.addEntry("Who accidentally broke her leg");
	moreStrings.addEntry("She slipped on the ice");
	moreStrings.addEntry("Not once, but thrice");
	moreStrings.addEntry("Take no pity on her, I beg");
	cout << "Size of moreStrings object: " << moreStrings.getSize() << endl;
	cout << "String 1: " << moreStrings.getEntry(0) << endl;
	cout << "String 2: " << moreStrings.getEntry(1) << endl;
	cout << "String 3: " << moreStrings.getEntry(2) << endl;
	cout << "String 4: " << moreStrings.getEntry(3) << endl;
	cout << "String 5: " << moreStrings.getEntry(4) << endl;

	cout << "--------------------------------------------------------------------------------\n";
	cout << "The overloaded assignment operator works correctly. (moreStrings = someStrings)\n";
	moreStrings = someStrings;
	cout << "Size of moreStrings object: " << moreStrings.getSize() << endl;
	cout << "String 1: " << moreStrings.getEntry(0) << endl;
	cout << "String 2: " << moreStrings.getEntry(1) << endl;
	cout << "String 3: " << moreStrings.getEntry(2) << endl;
	cout << "String 4: " << moreStrings.getEntry(3) << endl;
	cout << "String 5: " << moreStrings.getEntry(4) << endl;

	return 0;
}

void eatMemory(void) {
	int i = 0;

	for(i = 0; i < 5000000; i++) {
		new DynamicStringArray;
	}

	cout << "After creating new objects.\n";
	cin;
	cin.ignore(1000,'\n');
}
