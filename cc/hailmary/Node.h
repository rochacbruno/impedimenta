#ifndef NODE_H
#define NODE_H

#include <set>
#include "Cave.h"

namespace JeremyWumpus {
    const int NUM_OF_NEIGHBORS = 3;

    class Node {
        public:
            Node(int newID = 0);

            Cave data;

            int getID(void) const;
            void setNeighbors(Node*, Node*, Node*);
            Node* getRandomNeighbor(void) const;
            Node* getNeighbor(int) const;
        private:
            int ID;
            std::set<Node*> neighbors;
    };
}

#endif // #ifndef NODE_H
