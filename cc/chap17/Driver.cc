#include <iostream>
#include "CharNode.h"

/*-============================================================================/
unnamed namespace function declarations
/============================================================================-*/
namespace {
    using JeremysCode::CharNode;
    using JeremysCode::CharNodePtr;

    void headInsert(CharNodePtr& head, char newCh);
    void insert(CharNodePtr& afterMe, char newCh);
    CharNodePtr search(CharNodePtr& head, char target);
}

/*-============================================================================/
main()
/============================================================================-*/
int main(void) {
    using JeremysCode::CharNode;
    using JeremysCode::CharNodePtr;
    using std::cout;
    using std::endl;

    // testing basic functionality
    CharNode *head = new CharNode(NULL, '$');
    CharNodePtr current = NULL;
    // Testing insert()
    CharNodePtr head2 = NULL;
    insert(head2, '1');
    insert(head2, '2');
    insert(head2, '3');
    // Testing headInsert()
    CharNodePtr head3 = NULL;
    headInsert(head3, 'a');
    headInsert(head3, 'b');
    headInsert(head3, 'c');
    // testing search functionality
    current = search(head2, '2');

    if(current != NULL) {
        cout << "Result of search: " << current->getCh() << endl;
    }
    cout << "First list.\n";
    for(current = head; current != NULL; current = current->getLink()) {
        cout << current->getCh() << endl;
    }
    cout << "Second list.\n";
    for(current = head2; current != NULL; current = current->getLink()) {
        cout << current->getCh() << endl;
    }
    cout << "Third list.\n";
    for(current = head3; current != NULL; current = current->getLink()) {
        cout << current->getCh() << endl;
    }

    return 0;
}

/*-============================================================================/
unnamed namespace function definitions
/============================================================================-*/
namespace {
    /*-========================================================================/
    headInsert(CharNodePtr&, char)
    /========================================================================-*/
    void headInsert(CharNodePtr& head, char newCh) {
        head = new CharNode(head, newCh);
    }

    /*-========================================================================/
    inset(CharNodePtr&, char)
    /========================================================================-*/
   void insert(CharNodePtr& afterMe, char newCh) {
        if(afterMe == NULL) {
            // if afterMe is the head of a list with no nodes (and it points to
            // NULL) then add a first node to the list
            headInsert(afterMe, newCh);
        } else {
            // if afterMe points to a legitimate node somewhere in a list, then
            // correctly add the new node.
            afterMe->setLink(new CharNode(afterMe->getLink(), newCh));
        }
    }

    /*-========================================================================/
    CharNodePtr search(CharNodePtr& head, char target);
    /========================================================================-*/
    CharNodePtr search(CharNodePtr& head, char target) {
        CharNodePtr currentNode = head;

        // if the pointer passed points to an empty list, return NULL
        if(NULL == currentNode) {
                return NULL;
        }

        // assuming the pointer passed points to a legitimate node, then
        // search through the list for the target.
        // while the current node is not the last node (there are more nodes in
        // the list), AND while the target has not been found, keep searching
        while(currentNode->getLink() != NULL && currentNode->getCh() != target) {
            currentNode = currentNode->getLink();
        }
        // if one of those two conditions is met, return an appropriate pointer.
        if(currentNode->getCh() == target) {
            return currentNode;
        } else {
            return NULL;
        }
    }
}
