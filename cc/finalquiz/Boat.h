#ifndef BOAT_H
#define BOAT_H

namespace JeremysCode {
    class Boat {
        public:
            Boat(void);

            // return the 'hits' variable
            int getHits(void) const;
            // set the 'hits' variable to the argument passed
            void setHits(int);
        private:
            // a rudimentary measure of health
            int hits;
    };

    typedef Boat* BoatPtr;
}

#endif // #ifndef BOAT_H
