#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

void fillIntArray(int*, int, int = 0);
/*-------------------------------------/
Precondition: First arg is the name of the array. Second int is the number of elements to fill. ex. If you declared array[20], then the second arg can be from 0 to 20. Third arg is the index number of the first element to fill.

Postcondition: Elements of the array are filled in with random ints. WARNING: If you state fillIntArray(array[], 20, 1) then this function will attempt to fill elements array[1] through array[20] with values, even if they do not exist.

Last element filled = second arg + third arg - 1.
/-------------------------------------*/

void sortIntArray(int*, int, int = 0);
/*-------------------------------------/
Precondition:
Postcondition:
/-------------------------------------*/

int main(void) {
	srand(time(NULL));
	const int SIZE_OF_ARRAY = 5;

	int array[SIZE_OF_ARRAY] = {0};
//	int* pointer = &array[0];	// demonstration purposes. Uncomment one
//	int* pointer = array;		// of these two declarations. @demo
	int i = 0;

	cout << "After initialization: \n";
	for(i = 0; i < SIZE_OF_ARRAY; i++) {
		cout << "Array item "
		     << i
		     << " "
		     << array[i]
		     << endl;
	}
	cout << endl;

//	fillIntArray(pointer, SIZE_OF_ARRAY);	// demonstration purposes @demo
	fillIntArray(array, SIZE_OF_ARRAY);
	cout << "After random fill: \n";
	for(i = 0; i < SIZE_OF_ARRAY; i++) {
		cout << "Array item "
		     << i
		     << " "
		     << array[i]
		     << endl;
	}
	cout << endl;

	sortIntArray(array, SIZE_OF_ARRAY);
	cout << "After sort: \n";
	for(i = 0; i < SIZE_OF_ARRAY; i++) {
		cout << "Array item "
		     << i
		     << " "
		     << array[i]
		     << endl;
	}
	cout << endl;


	return 0;
}

void fillIntArray(int* arr, int numToFill, int offset) {
	int i;

	for(i = offset; i < (offset + numToFill); i++) {
		arr[i] = rand();
	}

	return;
}

void sortIntArray(int* arr, int toSort, int offset) {
	int i;
	int j;
	int temp;
	int smallest;

	for(i = offset; i < (offset + toSort - 1); i++) {
		for(smallest = j = i; j < (offset + toSort); j++) {
			if(arr[j] < arr[smallest]) {
				smallest = j;
			}
		}

		temp = arr[i];
		arr[i] = arr[smallest];
		arr[smallest] = temp;
	}

	return;
}
