#ifndef GRAPH_H
#define GRAPH_H

#include <vector>
#include "Node.h"

namespace JeremyWumpus {
    const int NUM_OF_NODES = 20;

    class Graph {
        public:
            Graph();

            void addNode(void);
            void linkNodes(void);
            bool findNodePresent(int target) const;
            const Node* findNode(int target) const;
        private:
            std::vector<Node> allNodes;
    };
}

#endif // #ifndef GRAPH_H
