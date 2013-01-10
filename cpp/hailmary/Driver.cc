#include <iostream>
#include <ctime>
#include <cstdlib>
#include "Graph.h"

int main(void) {
    using std::cout;
    using std::endl;
    using JeremyWumpus::Graph;
    srand(time(NULL));

    Graph theMap;

    cout << (theMap.findNode(2)->getNeighbor(0))->getID() << endl;
    cout << (theMap.findNode(2)->getNeighbor(1))->getID() << endl;
    cout << (theMap.findNode(2)->getNeighbor(2))->getID() << endl;
/*
    for(int i = 1; i <= 20; i++) {
        if(theMap.findNodePresent(i)) {
            cout << (theMap.findNode(i))->getID() << endl;
        }
    }
*/

    return 0;
}
