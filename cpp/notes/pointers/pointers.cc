#include <iostream>
using namespace std;

void func(int* ptr);
void func2(int ptr);
// You can declare void func2(int& ptr);, and there will be exactly no difference in behaviour.
// Weird.

/*-============================================================================/
Main()
/============================================================================-*/
int main(void) {
	typedef int* IntPtr;
	int *ptr1, *ptr2;
	IntPtr ptr3, ptr4;
	int num1 = 24;
	int i = 0;
	// Note that int* ptr3, ptr4; would result in only ptr3 being an actual pointer.
	// However, IntPtr ptr3, ptr4; would result in both being actual pointers.
	// Though it looks ugly, it is probably best to initialize pointers to NULL.
	// The above would be changed to, for example, int *ptr1 = NULL, *ptr2 = NULL;

	ptr1 = &num1;
	ptr2 = new int(1346);
	ptr3 = new int[10];
	// cannot do: ptr3 = new int[10] = {0};
	for(i = 0; i < 10; i++) {
		ptr3[i] = i * 12;
	}
	ptr4 = NULL;

	cout << "Always place the modifying symbol before the variable name. For example:\n";
	cout << "ptr1 == "
	     << ptr1
	     << endl;
	cout << "*ptr1 == "
	     << *ptr1
	     << endl;
	cout << "&num1 == "
	     << &num1
	     << endl;
	cout << "num1 == "
	     << num1
	     << endl;
	cout << endl;

	cout << "The only exception to this syntax rule is when declaring a arguments to a function. Now calling void func(int* ptr);\n";
	func(ptr1);
	cout << "Now calling void func2(int ptr); Note that this function could have been declared as void func2(int& ptr) and, weirdly enough, there is absolutely no change in behaviour.\n";
	func2(*ptr1);
	cout << endl;

	cout << "(Enter)> ";
	cin;
	cin.ignore(1000, '\n');
	cout << "Dynamic arrays are easily created and destroyed. The syntax for using dynamic arrays is exactly the same as with regular arrays.\n";
	for(i = 0; i < 10; i++) {
		cout << "ptr3["
		     << i
		     << "] = "
		     << ptr3[i]
		     << endl;
	}

	cout << "After already assigning ptr3 to an array of ints, the array of ints can be destroyed. The pointer remains, however, allowing you to assign a new array of ints to the pointer.\n";
	delete [] ptr3;
	ptr3 = new int[3];
	for(i = 0; i < 3; i++) {
		ptr3[i] = i * 2;
		cout << "ptr3["
		     << i
		     << "] = "
		     << ptr3[i]
		     << endl;
	}

	cout << "A cool note: you can increment and decrement pointer values.\n";
	cout << "ptr3[0] == "
	     << ptr3[0]
	     << endl;
/*	++ptr3;
	cout << "++ptr3\n"
	     << "ptr3[0] == "
	     << ptr3[0]
	     << endl;
*/

	delete ptr2;
	delete [] ptr3;
	return 0;
}

/*-============================================================================/
func()
/============================================================================-*/
void func(int* ptr) {
	cout << "*ptr == "
	     << *ptr
	     << endl;

	return;
}

/*-============================================================================/
func2()
/============================================================================-*/
void func2(int ptr) {
	cout << "ptr == "
	     << ptr
	     << endl;

	return;
}
