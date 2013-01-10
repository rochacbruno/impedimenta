/*-============================================================================/
All of the obstacles that a player will have to deal with in the Hunt The Wumpus game repeat themselves at an easily compartmentalized level: the cave. There are 20 caves in the arena, and each of them may contain a player, wumpus, bat, and pit. Additionally, every cave has three neighbors. This is the state information that the Cave class is responsible for keeping track of. Note that because each cave keeps track of only its neighbors, this data type is especially suited for banding together as a map. You cannot feasibly create Cave nodes and place them into a list.

The Cave class does _not_ worry about any state information beyond itself. If you want to move the wumpus to an adjacent cavern, this class does not offer any nicely bundled functions for doing so; you'll probably want to make a descendant class that is suited for doing so.
/============================================================================-*/
#ifndef CAVE_H
#define CAVE_H

namespace JeremyWumpus {
    class Cave {
        public:
            Cave(int newID = ' ', bool setHunter = false, bool setWumpus = false, bool setBat = false, bool setPit = false);

            // getters
            int getID(void) const;
            bool getHunterPresent(void) const;
            bool getWumpusPresent(void) const;
            bool getBatPresent(void) const;
            bool getPitPresent(void) const;
            bool getCreaturePresent(void) const;
            // setters
            void setID(int);
            void setHunterPresent(bool);
            void setWumpusPresent(bool);
            void setBatPresent(bool);
            void setPitPresent(bool);
            void clearCreatures(void);
        private:
            int ID;
            bool hunter;
            bool wumpus;
            bool bat;
            bool pit;
    };

    typedef Cave* CavePtr;
}

#endif // CAVE_H
