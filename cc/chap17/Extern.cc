#include "Extern.h"
#include <iostream>

namespace ExternalCode {
    void Extern::test(void) {
        using std::cout;
        using std::endl;

        cout << "test" << endl;

        return;
    }
}
