#include <iostream>
#include "Syrup.h"

namespace {
    using std::cout;

    void driverMessage(void) {
        cout << "Hello from Driver.cc's unnamed namespace.\n";

        return;
    }
}

int main(void) {
    using std::cout;
    using std::endl;
    using JeremySampleData::Syrup;
    Syrup mySyrup;

    mySyrup.setWeight(15);
    mySyrup.setGrade('B');

    cout << "Syrup weight: " << mySyrup.getWeight() << endl;
    cout << "Syrup grade: " << mySyrup.getGrade() << endl;
    cout << "I cannot, for the life of me, figure out how to access syrupMessage() from any place within this file.\n";

    return 0;
}
