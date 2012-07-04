#include <iostream>
#include "Rectangle.h"
#include "Triangle.h"

int main(void) {
    using JeremyFigure::Rectangle;
    using JeremyFigure::Triangle;
    using std::cout;
    using std::endl;
    using std::cin;

    Rectangle shapeOne;
    Triangle shapeTwo;
    int i = 0;

    shapeOne.center();
    for(i = 0; i < 8; i++) {cout << endl;}
    cout << "Rectangle!\n";
    cout << "(enter)\n";
    cout << "> ";
    cin;
    cin.clear();
    cin.ignore(1000, '\n');

    shapeTwo.center();
    for(i = 0; i < 8; i++) {cout << endl;}
    cout << "Triangle!\n";
    cout << "(enter)\n";
    cout << "> ";
    cin;
    cin.clear();
    cin.ignore(1000, '\n');

    return 0;
}
