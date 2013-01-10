#include <iostream>
using namespace std;

/*=============================================================================/
class declaration
/=============================================================================*/
class IMakeObjects {
	public:
		IMakeObjects();
		IMakeObjects(int, int, int);
		void printContents(void) const;
	private:
		int a, b, c;
};

/*=====================================/
IMakeObjects constructor
/=====================================*/
IMakeObjects::IMakeObjects() {
	a = 0;
	b = 0;
	c = 0;

	return;
}

/*=====================================/
IMakeObjects constructor
/=====================================*/
IMakeObjects::IMakeObjects(int aValue, int bValue, int cValue) {
	a = aValue;
	b = bValue;
	c = cValue;

	return;
}

/*=====================================/
IMakeObjects member function
/=====================================*/
void IMakeObjects::printContents(void) const {
	cout << a << endl;
	cout << b << endl;
	cout << c << endl;

	return;
}

/*=============================================================================/
Another class declaration. Uses the above class in its declaration.
/=============================================================================*/
class DoubleUp {
	public:
		DoubleUp();
		DoubleUp(double, int, int, int);
		void printAll(void) const;
	private:
		double height;
		IMakeObjects intBall;
};

/*=====================================/
DoubleUp constructor
/=====================================*/
DoubleUp::DoubleUp()
	: height(0.00), intBall()
{
	; // do nothing
}

/*=====================================/
DoubleUp constructor
commented out constructor below accomplishes same task with different syntax
/=====================================*/
DoubleUp::DoubleUp(double newHeight, int num1, int num2, int num3) {
	height = newHeight;
	intBall = IMakeObjects(num1, num2, num3);	// explicit constructor call
}

/*=====================================/
Yet another DoubleUp constructor.
Compact, though unclear, syntax. Preferred?!
/=====================================*/
/*
DoubleUp::DoubleUp(double newHeight, int num1, int num2, int num3)
	:height(newHeight), intBall(num1, num2, num3)
{
	; // do nothing
}
*/

/*=====================================/
DoubleUp member function
/=====================================*/
void DoubleUp::printAll(void) const {
	cout << height << endl;
	intBall.printContents();
}

/*=============================================================================/
Main program.
/=============================================================================*/
int main(void) {
	IMakeObjects object1;
	IMakeObjects object2(1, 2, 3);
	DoubleUp complexObject1;
	DoubleUp complexObject2(3.14159, 3, 2, 1);

	cout << "object1.printContents();" << endl;
	object1.printContents();
	cout << "object2.printContents();" << endl;
	object2.printContents();
	cout << "complexObject1.printAll();" << endl;
	complexObject1.printAll();
	cout << "complexObject2.printAll();" << endl;
	complexObject2.printAll();
}
