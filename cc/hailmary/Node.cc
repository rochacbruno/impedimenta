#include "Node.h"
#include <cstdlib>
#include <iostream>

namespace JeremyWumpus {
    /*-========================================================================/
    Constructor. Sets the ID of the new node to the given argument, and makes
    no neighbors.
    /========================================================================-*/
    Node::Node(int newID) 
        : ID(newID)
    {
        neighbors.clear();
    }

    /*-========================================================================/
    Returns the ID number of this node.
    /========================================================================-*/
    int Node::getID(void) const {
        return ID;
    }

    /*-========================================================================/
    Set the neighboring nodes of this node. Blindly accepts the arguments. 
    Replaces all old neighbors.
    /========================================================================-*/
    void Node::setNeighbors(Node* neighbor1, Node* neighbor2, Node* neighbor3) {
        neighbors.clear();
        neighbors.insert(neighbor1);
        neighbors.insert(neighbor2);
        neighbors.insert(neighbor3);
    }

    /*-========================================================================/
    Get a random pointer to a neighbor.
    /========================================================================-*/
    Node* Node::getRandomNeighbor(void) const {
        using std::rand;
        using std::set;

        int limit = rand() % NUM_OF_NEIGHBORS;
        set<Node*>::const_iterator iter = neighbors.begin();
        for(int i = 0; i < limit; i++) {
            iter++;
        }
        return *iter;
    }

    /*-========================================================================/
    Get a consistent pointer to a neighbor. Only accepts arguments 0-2.
    /========================================================================-*/
    Node* Node::getNeighbor(int target) const {
        using std::set;
        using std::cerr;
        using std::endl;

        if(target >= 3 || target < 0) {
            cerr << "Node::getNeighbor cannot return specified neighbor.\n";
            cerr << "Argument must be: (0 >= arg < 3).\n";
            cerr << "arg given is: " << target << endl;
            cerr << "Exiting due to error.\n";
            exit(1);
        }

        set<Node*>::const_iterator iter = neighbors.begin();
        for(int i = 0; i < target; i++) {
            iter++;
        }

        return *iter;
    }
}
