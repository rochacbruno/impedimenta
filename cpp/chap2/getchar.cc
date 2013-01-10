#include <iostream>
using namespace std;

int main(void) {
	const int SIZE_OF_ARRAY = 5;
	char testArray[SIZE_OF_ARRAY] = {'1','2','3','4','5'};
	int arrayIndex = 0;

	cout << "indexed output: ";
	for(arrayIndex = 0; arrayIndex < SIZE_OF_ARRAY; arrayIndex++) {
		cout << testArray[arrayIndex];
	}
	cout << endl;
	cout << "cout output: " << testArray << endl;

	cout << endl;
	cout << "Please enter a short string.\n";
	cin >> testArray;

	cout << "cout output: " << testArray << endl;
	cout << "indexed output: ";
	for(arrayIndex = 0; arrayIndex < SIZE_OF_ARRAY; arrayIndex++) {
		cout << testArray[arrayIndex];
	}
	cout << endl;

	cout << endl;
	cout << "Size of '1': " << sizeof('1') << endl;
	cout << "Sizeof \"1\": " << sizeof("1") << endl;

	return 0;
}
