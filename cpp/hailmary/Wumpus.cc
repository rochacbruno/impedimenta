#include "Wumpus.h"
#include <iostream>

namespace JeremyWumpus {
    void Wumpus::Alert(void) const {
        using std::cout;

        cout << "Wumpus!\n";

        return;
    }

    std::string Wumpus::getType(void) const {
        return "wumpus";
    }
}
