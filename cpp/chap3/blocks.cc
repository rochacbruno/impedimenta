#include <iostream>
using namespace std;

int main(void) {
	cout << "Block level 0\n";

	{
		int x = 1;
		cout << "Block level 1: " << x << endl;
		{
			cout << "Block level 2: " << x << endl;
			int x = 2;
			cout << "Block level 2: " << x << endl;
			{
				cout << "Block level 3: " << x << endl;
				int x = 3;
				cout << "Block level 3: " << x << endl;
			}
			cout << "Block level 2: " << x << endl;
		}
		cout << "Block level 1: " << x << endl;
	}

	return 0;
}
