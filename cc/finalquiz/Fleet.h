#ifndef FLEET_H
#define FLEET_H

#include "Boat.h"

namespace JeremysCode {
    class Fleet {
        public:
            Fleet();                        // Constructor
            Fleet(const Fleet& otherFleet);   // Copy Constructor
            ~Fleet();                       // Destructor

            Fleet& operator=(const Fleet& rightFleet);

            int getSize(void) const;
            void addBoat(void);
            void delBoat(void);
            // return the sum of the 'hits' variable of all boats
            int fleetHealth(void) const;
            // return the 'hits' variable of a particular boat
            int boatHealth(int choice) const;
            // randomly distributes damage to boats into the fleet
            // does so by incrementing the 'hits' variable in random boats
            // returns the 'damage' variable
            void whackFleet(int damage);
        private:
            int size;       // This describes the size of variable 'array'
            BoatPtr array;  // array is a pointer to a collection of Boats
    };
}

#endif // #ifndef FLEET_H
