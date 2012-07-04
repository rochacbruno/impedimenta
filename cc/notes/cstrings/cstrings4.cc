#include <iostream>
#include <cstring>
using std::cin;
using std::cout;

int main(void) {
	char ch;

	cout << "This program will repeat input on the next line. This happens because input is buffered. If it was not, each character would be repeated as soon as it was entered.\n";
	do {
		cin.get(ch);
		cout << ch;
	} while(ch != '\n');

	return 0;
}
