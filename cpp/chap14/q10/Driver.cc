/*
Jeremy Audet
Completed on November 7th, 2010.
Coded for Object Oriented Programming at Vermont Technical College, taught by Michael Soulia.

This program is a driver intended to demonstrate the use of class Pet and its descendants, Rock and Dog.
*/

#include <iostream>
#include "Rock.h"
#include "Dog.h"

int main(void) {
    // Appropriate using directives. Applies to main(), not the global namespace.
    using std::cout;
    using std::endl;
    using Creature::Dog;
    using Creature::Rock;

    // Creation of variables and objects
    Dog testPet1;
    Rock testPet2("Gandalf", 2000, -3000);
    Dog testPet3("Loriochi", 19, 60, "corgy");

    // make some changes here...
    testPet2.setWeightKg(340000);   // notice that I am calling a function defined in Pet

    // and then display the results of what has been done.
    cout << "testPet1 name:       " << testPet1.getName() << endl;
    cout << "testPet1 age:        " << testPet1.getAge() << endl;
    cout << "testPet1 weight (kg) " << testPet1.getWeightKg() << endl;
    cout << "testPet1 lifespan:   " << testPet1.getLifespan() << endl;

    cout << endl;
    cout << "testPet2 name:       " << testPet2.getName() << endl;
    cout << "testPet2 age:        " << testPet2.getAge() << endl;
    cout << "testPet2 weight (kg) " << testPet2.getWeightKg() << endl;
    cout << "testPet2 lifespan:   " << testPet2.getLifespan() << endl;

    cout << endl;
    cout << "testPet3 name:       " << testPet3.getName() << endl;
    cout << "testPet3 age:        " << testPet3.getAge() << endl;
    cout << "testPet3 weight (kg) " << testPet3.getWeightKg() << endl;
    cout << "testPet3 lifespan:   " << testPet3.getLifespan() << endl;

    return 0;
}
