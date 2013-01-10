/*-============================================================================/
Here's a breif reproduction of the Organism class declaration:
class Organism {
    public:
        void Organism();

        virtual void move() = 0;

        int getXCoordinate() const;
        int getYCoordinate() const;
        int getTimeSinceBreeding() const;

        void resetTimeSinceBreeding();
        static void setBoardSize(int, int);
    private:
        int xCoordinate;
        int yCoordinate;
        static int xLimit;
        static int yLimit;
        int timeSinceBreeding;
};
/============================================================================-*/
#include "ORGANISM_H"

namespace JeremyCreatures {
    Organism::Organism()
        : timeSinceBreeding(0)
    {
        // Some safe values for the board size.
        if(xLimit < 0) {
            xLimit = 20;
        }
        if(yLimit < 0) {
            yLimit = 20;
        }

        // need to set these randomly based on board size and location of other
        // objects
        xCoordinate = 0;
        yCoordinate = 0;
    }
} // end namespace
