#include <iostream>
using namespace std;

class MyStructure {
	public:
		MyStructure();
		MyStructure(int givenInt);
		void showNumber(void);
	private:
		int number;
};

void showNumber(void);

int main(void) {
	MyStructure jumbleOne;
	MyStructure jumbleTwo(3);

	jumbleOne.showNumber();
	jumbleTwo.showNumber();

	return 0;
}

MyStructure::MyStructure() {
	number = 0;

	return;
}

MyStructure::MyStructure(int givenInt)
	:number(givenInt)
{
	return;
}

void MyStructure::showNumber(void) {
	cout << number << endl;
}
