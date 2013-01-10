#include <iostream>
using namespace std;

struct ShoeType {
	double price;
	double footSize;
};

ShoeType discount(ShoeType oldRecord);

int main(void) {
	ShoeType thatShoe;
	thatShoe.price = 10.0;
	thatShoe.footSize = 10.5;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(2);

	thatShoe = discount(thatShoe);

	cout.precision(2);
	cout << "Shoe price: $"
	     << thatShoe.price
	     << endl;
	cout.precision(1);
	cout << "Foot size: "
	     << thatShoe.footSize
	     << endl;

	return 0;
}

ShoeType discount(ShoeType oldRecord) {
	oldRecord.price = oldRecord.price * 0.9;

	return oldRecord;
}
