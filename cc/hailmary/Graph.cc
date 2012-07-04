#include "Graph.h"
#include <cstdlib>
#include <iostream>

namespace JeremyWumpus {
    /*-========================================================================/
    Constructor. By default, creates 20 nodes with ID numbers 1-20.
    /========================================================================-*/
    Graph::Graph() {
        allNodes.resize(0);

        for(int i = 0; i < NUM_OF_NODES; i++) {
            addNode();
        }
        linkNodes();
    }

    /*-========================================================================/
    Add a node to the allNodes vector. Automatically assign ID numbers to new 
    nodes created.
    /========================================================================-*/
    void Graph::addNode(void) {
        allNodes.push_back(allNodes.size() + 1);

        return;
    }

    /*-========================================================================/
    There _MUST_ be 20 nodes for this function to work correctly.
    /========================================================================-*/
    void Graph::linkNodes(void) {
        // Thank you!
		int links[NUM_OF_NODES][NUM_OF_NEIGHBORS] = {
			{1,2,3}, {0,4,16}, {0,5,6}, {0,11,19}, {1,5,8},
			{2,4,7}, {2,10,11}, {5,9,10}, {4,9,12}, {7,8,13},
			{6,7,14}, {3,6,15}, {8,16,17}, {9,14,17}, {10,13,15},
			{11,14,18}, {1,12,19}, {12,13,18}, {15,17,19}, {3,16,18}
		};

        int i = 0;

        for(i = 0; i < NUM_OF_NODES; i++) {
            allNodes[i].setNeighbors(&allNodes[links[i][0]], &allNodes[links[i][1]], &allNodes[links[i][2]]);
        }
    }

    /*-========================================================================/
    Check to see if a node is present. This _must_ be separate from the
    findNode() function, as findNode() cannot return NULL if its target is not
    found.
    /========================================================================-*/
    bool Graph::findNodePresent(int target) const {
        for(int i = 0; i < allNodes.size(); i++) {
            if(allNodes[i].getID() == target) {
                return true;
            }
        }

        return false;
    }

    /*-========================================================================/
    Find a node with the target argument. If node not found, terminate program.
    (cannot return NULL).
    /========================================================================-*/
    const Node* Graph::findNode(int target) const {
        using std::cerr;

        for(int i = 0; i < allNodes.size(); i++) {
            if(allNodes[i].getID() == target) {
                return &allNodes[i];
            }
        }

        cerr << "Error: Graph::findNode() cannot find target. Exiting due to error.\n";
        exit(1);
    }
}
