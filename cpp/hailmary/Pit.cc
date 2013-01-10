#include "Pit.h"
#include <iostream>

namespace JeremyWumpus {
    void Pit::Alert(void) const {
        using std::cout;

        cout << "Pit!\n";

        return;
    }

    std::string Pit::getType(void) const {
        return "pit";
    }
}
