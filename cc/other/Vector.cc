#include <iostream>
#include <vector>

int main(void) {
	using std::cout;
	using std::endl;
	using std::vector;

	const int size = 3;
	vector<int> numbers;
	numbers.resize(size);
	int numbers2[size] = {1, 2, 3};
	int i = 0;

	numbers[0] = 1;
	numbers[1] = 2;
	numbers[2] = 3;

	for(i = 0; i < size; i++) {
		cout << numbers[i] << endl;
	}
	for(i = 0; i < size; i++) {
		cout << numbers2[i] << endl;
	}

	return 0;
}
