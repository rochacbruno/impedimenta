#include "Fleet.h"
#include <cstdlib>

namespace JeremysCode {
    /*-========================================================================/
    Fleet()
    /========================================================================-*/
    Fleet::Fleet() {
        size = 5;
        array = new Boat[size];
    }

    /*-========================================================================/
    Fleet(const Fleet& otherFleet)
    /========================================================================-*/
    Fleet::Fleet(const Fleet& otherFleet) {
        size = otherFleet.size;
        array = new Boat[size];
        for(int i = 0; i < size; i++) {
            array[i] = otherFleet.array[i];
        }
    }

    /*-========================================================================/
    Fleet& operator=(const Fleet& rightFleet)
    /========================================================================-*/
    Fleet& Fleet::operator=(const Fleet& rightFleet) {
        // guard against attempting to assign an object to itself
        if(this != &rightFleet) {
            // size should be the same as on the right side...
            size = rightFleet.size;

            // make the array point to a set Boats of the same size
            array = new Boat[size];
            // make the new boats have the same contents as on the right side
            for(int i = 0; i < size; i++) {
                array[i] = rightFleet.array[i];
            }
        }

        // convention that allows for chaining assignment statements
        return *this;
    }

    /*-========================================================================/
    ~Fleet()
    /========================================================================-*/
    Fleet::~Fleet() {
        delete[] array;
    }

    /*-========================================================================/
    int getSize(void) const
    /========================================================================-*/
    int Fleet::getSize(void) const {
        return size;
    }

    /*-========================================================================/
    void addBoat(void)
    /========================================================================-*/
    void Fleet::addBoat(void) {
        BoatPtr newArray = new Boat[size + 1];

        for(int i = 0; i < size; i++) {
            newArray[i] = array[i];
        }

        delete[] array;
        array = newArray;
        size++;
    }

    /*-========================================================================/
    void delBoat(void)
    /========================================================================-*/
    void Fleet::delBoat(void) {
        // deal with special cases
        if(0 == size) {
            return;
        } else if(1 == size) {
            delete[] array;
            array = NULL;
            size = 0;
        }

        // generic approach for shrinking the array
        // create a new array of boats, one element smaller in size
        BoatPtr newArray = new Boat[--size];
        for(int i = 0; i < size; i++) {
            newArray[i] = array[i];
        }
        delete[] array;     // delete the old array
        array = newArray;   // use the newly created array

        return;
    }

    /*-========================================================================/
    int fleetHealth(void) const
    /========================================================================-*/
    int Fleet::fleetHealth(void) const {
        int totalHealth = 0;
        for(int i = 0; i < size; i++) {
            totalHealth += array[i].getHits();
        }

        return totalHealth;
    }

    int Fleet::boatHealth(int choice) const {
        if(choice >= size || choice < 0) {
            exit(1);
        }

        return array[choice].getHits();
    }

    /*-========================================================================/
    void whackFleet(int)
    /========================================================================-*/
    void Fleet::whackFleet(int damage) {
        using std::rand;
        int choice;

        for(int i = 0; i < damage; i++) {
            choice = rand() % size;
            array[choice].setHits(array[choice].getHits() + 1);
        }

        return;
    }
}
