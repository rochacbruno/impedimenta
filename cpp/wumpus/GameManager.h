/*-============================================================================/
The GameManager class has two purposes. Firstly, it creates and populates a game map. Secondly, it interfaces with the player. You might think that this is, in a nutshell, everything that occurs in the Hunt the Wumpus game. If so, you'd be right. The GameManager class is very easy to use. Simply create a GameManager object and call the playGame function. playGame takes care of _everything_ else.
/============================================================================-*/
#ifndef GAMEMANAGER_H
#define GAMEMANAGER_H

#include <vector>
#include "DynamicCave.h"

namespace JeremyWumpus {
    const int MAP_SIZE = 20;

    class GameManager {
        public:
            GameManager();

            void playGame(void);
        private:
            // Holds all of the nodes used in the game.
            std::vector<DynamicCave> gameMap;
            // How many bats and pits to place in-game?
            int numOfBats, numOfPits;
            // You only have five arrows. If you run out, you die.
            int arrows;
            // A list of node ID numbers to use when firing an arrow
            std::vector<int>arrowPath;
            // Used to keep track of the arrow when the hunter shoots
            DynamicCave* arrowLocation;
            // Used to keep track of the wumpus' location at all times
            DynamicCave* wumpusLocation;
            // Used to keep track of the hunter's location at all times
            DynamicCave* hunterLocation;

            // make gameMap the appropriate size and link the nodes together
            void createMap(void);
            // Fill gameMap with bats, pits, and a wumpus and hunter. Also
            // set the hunterLocation variable.
            void populateMap(void);
            // Check to see if the wumpus is still alive
            bool wumpusAlive(void) const;
            // check to see if the hunter is still alive
            bool hunterAlive(void) const;
            // show instructions
            void showHelp(void);
            // play an individual turn -- move the hunter
            void playTurn(void);        // NEEDS DEVELOPMENT
            // show the main menu and get a choice from the user
            static int mainMenu(void);
            // Check to see if arrowPath[arg] matches any of arrowLocation's
            // neighbors
            bool arrowPathValid(int);
            DynamicCave* find(int);

            static void deathByWumpus(void);
            static void deathByArrow(void);
            static void deathByPit(void);
            static void moveByBat(void);
            static void win(void);
    };
}

#endif // #ifndef GAMEMANAGER_H
