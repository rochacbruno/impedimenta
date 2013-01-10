#ifndef ORGANISM_H
#define ORGANISM_H

namespace JeremyCreatures {
    class Organism {
        public:
            void Organism();
            // Precondition: Use of this constructor is not advised. Use
            // Organism(int, int) instead.
            // Postcondition: Organism will be placed at -1,-1. This indicates
            // that the organism was not intelligently assigned a location.
            // Other member functions (such as move()) will react to this
            // appropriately.

            void Organism(int, int);
            // Precondition: pass two ints >= 0
            // Postcondition: xCoordinate and yCoordinate will be set to first
            // and second argument, respectively. Constructor will only check to
            // make sure that location assigned is not out of bounds.

            virtual void move() = 0;
            // Precondition: none.
            // Postcondition: Organism will assign itself a new location. Ant and 
            // Doodlebug objects (plus any other derived classes) will move 
            // according to different rules.

            int getXCoordinate() const;
            int getYCoordinate() const;
            int getTimeSinceBreeding() const;
            // Precondition: none
            // Postcondition: Value of the corresponding variable will be returned.

            void resetTimeSinceBreeding();
            // Precondition: none
            // Postcondition: variable timeSinceBreeding will be set to 0.
            static void setBoardSize(int, int);
            // Precondition: Must pass two ints >= 0. This function MUST be
            // called before any Organism (or derived) objects are created.
            // Postcondition: xLimit and yLimit will be set equal to the first
            // and second argument, respectively.
        private:
            int xCoordinate;
            int yCoordinate;
            // Keeps track of the current organism location.
            // 0 <= xCoordinate <= xLimit. Same with yCoordinate. 

            static int xLimit;
            static int yLimit;
            // These two variables determine the size of the game board. Every
            // creature should exist on a board of the same size. Board
            // numbering starts at zero. If you wanted a 20x20 game board, 
            // xLimit and yLimit should both be 19. If xLimit and yLimit are
            // both 0, you will have a 1x1 game board. These variables MUST be
            // set prior to instantiating any Organism (or derived) objects.

            int timeSinceBreeding;
            // Records how many turns it has been since this creature has last
            // reproduced. If this number reaches a certain limit (probably set in
            // main), then timeSinceBreeding should be reset to 0 and a new organism
            // created.
    }; // end class
} // end namespace

#endif // #ifndef ORGANISM_H
