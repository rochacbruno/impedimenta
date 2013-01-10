#include "Bat.h"
#include <iostream>

namespace JeremyWumpus {
    void Bat::Alert(void) const {
        using std::cout;

        cout << "Bat!\n";

        return;
    }

    std::string Bat::getType(void) const {
        return "bat";
    }
}
