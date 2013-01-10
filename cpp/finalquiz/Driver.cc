/*-========================================================================/
This program demonstrates the use of the Fleet class (and, by proxy, the Boat class). It simply creates two Fleet objects and then exercises the functions declared in such. This program exercises the copy constructor, overloaded assignment operator, and destructor, among some others. The Fleet class is not a descendant of the Boat class; rather the Fleet class creates a pointer to an array of Boat objects. Translation: Fleet creates a dynamic array of Boat objects.

Three pillars of OOP: encapsulation, inheritance, polymorphism
Big three in OOP: copy constructor, destructor, assignment operator
What the frick is an ENTITY object? I can find absolutely no reference to such a thing, either in our book or on the web.
/========================================================================-*/
#include <iostream>
#include "Fleet.h"
#include <cstdlib>
#include <ctime>

int main(void) {
    using std::cout;
    using std::endl;
    using std::cin;
    using JeremysCode::Fleet;
    using std::srand;
    using std::rand;
    srand(time(NULL));

    const int damageLimit = 10;
    int i = 0;
    Fleet spanishArmada;
    spanishArmada.addBoat();
    spanishArmada.addBoat();
    spanishArmada.delBoat();
    // fleet should have 5 + 1 + 1 - 1 = 6 boats in it

    // assign some damage
    spanishArmada.whackFleet(rand() % damageLimit);
    cout << "Ze Spanish Armada!\n";
    cout << "Fleet Health: " << spanishArmada.fleetHealth() << endl;
    for(i = 0; i < spanishArmada.getSize(); i++) {
        cout << "Boat "
             << i
             << " Health: "
             << spanishArmada.boatHealth(i)
             << endl;
    }
    cout << endl;

    // Copy Constructor!
    Fleet englishArmada(spanishArmada);
    cout << "Thee English Armada!\n";
    cout << "Fleet Health: " << englishArmada.fleetHealth() << endl;
    for(i = 0; i < englishArmada.getSize(); i++) {
        cout << "Boat "
             << i
             << " Health: "
             << englishArmada.boatHealth(i)
             << endl;
    }
    cout << endl;

    // prompt the user to continue, as quite a bit has already been output
    cout << "(enter)\n> ";
    cin;
    cin.ignore(1000, '\n');

    // assign some more damage
    spanishArmada.whackFleet(rand() % damageLimit);
    cout << "Ze Spanish Armada!\n";
    cout << "Fleet Health: " << spanishArmada.fleetHealth() << endl;
    for(i = 0; i < spanishArmada.getSize(); i++) {
        cout << "Boat "
             << i
             << " Health: "
             << spanishArmada.boatHealth(i)
             << endl;
    }
    cout << endl;

    // Assignment Operator!
    englishArmada = spanishArmada;
    cout << "Thee English Armada!\n";
    cout << "Fleet Health: " << englishArmada.fleetHealth() << endl;
    for(i = 0; i < englishArmada.getSize(); i++) {
        cout << "Boat "
             << i
             << " Health: "
             << englishArmada.boatHealth(i)
             << endl;
    }
    cout << endl;

    return 0;
}
