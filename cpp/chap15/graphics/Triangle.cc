#include "Triangle.h"
#include <iostream>

namespace JeremyFigure {
    void Triangle::draw(void) const {
        using std::cout;
        using std::endl;

        int i = 0;

        cout << "                                       **\n";
        cout << "                                      *  *\n";
        cout << "                                     *    *\n";
        cout << "                                    *      *\n";
        cout << "                                   *        *\n";
        cout << "                                  ************\n";

        return;
    }
}
