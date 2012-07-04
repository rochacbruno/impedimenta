#include "Figure.h"
#include <iostream>

namespace JeremyFigure {
    void Figure::center(void) const {
        using std::cout;

        erase();
        draw();
        // You do not need to make a function call such as JeremyFigure::Figure::erase().
        // This is because you are already in the JeremyFigure::Figure namespace.

        return;
    }

    void Figure::erase(void) const {
        using std::cout;
        using std::endl;

        int i;

        for(i = 0; i < 100; i++) {
            cout << endl;
        }

        return;
    }
}
