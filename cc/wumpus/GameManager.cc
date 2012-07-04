#include "GameManager.h"
#include <iostream>
#include <cstdlib>

namespace JeremyWumpus {
    /*-========================================================================/
    GameManager()
    /========================================================================-*/
    GameManager::GameManager()
        : numOfBats(2), numOfPits(2), hunterLocation(NULL), arrowLocation(NULL), arrows(5)
    {
        arrowPath.resize(0);
        createMap();
        populateMap();
    }

    /*-========================================================================/
    int playGame(void) const
    /========================================================================-*/
    void GameManager::playGame(void) {
        using std::cout;
        using std::cerr;
        using std::endl;

        while(1) {
            switch(mainMenu()) {
                case 1:
                    populateMap();
                    cout << wumpusLocation->getID() << endl;
                    while(hunterAlive() && wumpusAlive()) {
                        playTurn();
                    }
                    break;

                case 2:
                    showHelp();
                    break;

                case 3:
                    cout << "Have a good day!\n";
                    return;
                    break;

                default:
                    cerr << "Whoops -- there's been a serious problem getting input.\n"
                         << "Exiting due to error.\n";
                    exit(1);
                    break;
            }
        }

        return;
    }

    /*-========================================================================/
    void createMap(void)
    /========================================================================-*/
    void GameManager::createMap(void) {
        gameMap.resize(MAP_SIZE);

        // Note how I'm setting the ID numbers!
        // Nodes have ID numbers 1-20, not 0-19.
        for(int i = 0; i < MAP_SIZE; i++) {
            gameMap[i].setID(i + 1);
        }

        // Node ID numbers are _totally_ unrelated from their numbered vector 
        // position. Node neighbors are set according to the map in 
        // ../stuff/cavemap.png That map describes vector position numbers, not 
        // node IDs.
        gameMap[0].setNeighbors(&gameMap[1], &gameMap[5], &gameMap[4]);
        gameMap[1].setNeighbors(&gameMap[2], &gameMap[7], &gameMap[0]);
        gameMap[2].setNeighbors(&gameMap[1], &gameMap[9], &gameMap[3]);
        gameMap[3].setNeighbors(&gameMap[2], &gameMap[11], &gameMap[4]);
        gameMap[4].setNeighbors(&gameMap[3], &gameMap[13], &gameMap[0]);
        gameMap[5].setNeighbors(&gameMap[0], &gameMap[6], &gameMap[14]);
        gameMap[6].setNeighbors(&gameMap[7], &gameMap[15], &gameMap[5]);
        gameMap[7].setNeighbors(&gameMap[1], &gameMap[8], &gameMap[6]);
        gameMap[8].setNeighbors(&gameMap[7], &gameMap[16], &gameMap[9]);
        gameMap[9].setNeighbors(&gameMap[8], &gameMap[2], &gameMap[10]);
        gameMap[10].setNeighbors(&gameMap[9], &gameMap[17], &gameMap[11]);
        gameMap[11].setNeighbors(&gameMap[10], &gameMap[3], &gameMap[12]);
        gameMap[12].setNeighbors(&gameMap[11], &gameMap[18], &gameMap[13]);
        gameMap[13].setNeighbors(&gameMap[12], &gameMap[4], &gameMap[14]);
        gameMap[14].setNeighbors(&gameMap[13], &gameMap[19], &gameMap[5]);
        gameMap[15].setNeighbors(&gameMap[6], &gameMap[16], &gameMap[19]);
        gameMap[16].setNeighbors(&gameMap[8], &gameMap[17], &gameMap[15]);
        gameMap[17].setNeighbors(&gameMap[16], &gameMap[10], &gameMap[18]);
        gameMap[18].setNeighbors(&gameMap[17], &gameMap[12], &gameMap[19]);
        gameMap[19].setNeighbors(&gameMap[18], &gameMap[14], &gameMap[15]);

        return;
    }

    /*-========================================================================/
    void populateMap(int, int)
    /========================================================================-*/
    void GameManager::populateMap(void) {
        using std::cerr;
        using std::rand;
        int i = 0;
        int location = 0;

        if(numOfBats < 0 || numOfPits < 0) {
            cerr << "Cannot place bats or pits, as an argument to populateMap() is negative.\n";
            cerr << "Exiting due to error.\n";
            exit(1);
        }

        if(numOfBats + numOfPits + 2 >= MAP_SIZE) {
            cerr << "Not enough room to place the hunter. Exiting due to error.\n";
            exit(1);
        }

        // Error checking is taken care of. First, clear the map.
        for(i = 0; i < MAP_SIZE; i++) {
            gameMap[i].clearCreatures();
        }

        // Then, place bats, pits, wumpus, and hunter all in unique caves.
        // bats
        for(i = 0; i < numOfBats; i++) {
            do {
                location = rand() % MAP_SIZE;
            } while(gameMap[location].getCreaturePresent());
            gameMap[location].setBatPresent(true);
        }
        // pits
        for(i = 0; i < numOfPits; i++) {
            do {
                location = rand() % MAP_SIZE;
            } while(gameMap[location].getCreaturePresent());
            gameMap[location].setPitPresent(true);
        }
        // hunter
        do {
            location = rand() % MAP_SIZE;
        } while(gameMap[location].getCreaturePresent());
        gameMap[location].setHunterPresent(true);
        hunterLocation = &gameMap[location];
        // wumpus
        do {
            location = rand() % MAP_SIZE;
        } while(gameMap[location].getCreaturePresent());
        gameMap[location].setWumpusPresent(true);
        wumpusLocation = &gameMap[location];

        return;
    }

    /*-========================================================================/
    bool wumpusAlive(void)
    /========================================================================-*/
    bool GameManager::wumpusAlive(void) const {
        for(int i = 0; i < MAP_SIZE; i++) {
            if(gameMap[i].getWumpusPresent() == true) {
                return true;
            }
        }

        return false;
    }

    /*-========================================================================/
    bool hunterAlive(void)
    /========================================================================-*/
    bool GameManager::hunterAlive(void) const {
        for(int i = 0; i < MAP_SIZE; i++) {
            if(gameMap[i].getHunterPresent() == true) {
                return true;
            }
        }

        return false;
    }

    /*-========================================================================/
    void showHelp(void) const
    /========================================================================-*/
    void GameManager::showHelp(void) {
        using std::cout;
        using std::endl;
        using std::cin;

        cout << "The Wumpus lives in a cave of "
             << MAP_SIZE
             << " caverns. Each cavern has 3 tunnels leading off to other rooms.\n";
        cout << endl;
        cout << "HAZARDS\n"
             << numOfPits << " caverns have Bottomless Pits in them. If you go there, you fall to your death!\n"
             << numOfBats << " caverns have Super Bats in them. If you stumble upon a bat, it will pick you\n"
             << "up and randomly transport you to another cavern. This could be troublesome,\n"
             << "depending upon where you land.\n";
        cout << endl;
        cout << "WUMPUS\n"
             << "The wumpus is not bothered by the hazards of the cave. He has sucker feet and is\n"
             << "too big for the bats to lift! Usually he is asleep. Two things will wake him up:\n"
             << "you entering his room or your shooting an arrow. If the wumpus wakes up, there\n"
             << "is a 75% chance he will move to an adjacent room and a 25% chance he will stay.\n"
             << "If you and him end up in the same cavern -- he eats you up!\n";
        cout << endl;
        cout << "More (enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');

        cout << "YOU\n"
             << "Each turn you may move or shoot an arrow. If you move, just select a\n"
             << "neighboring cavern and you'll trudge on down. When shooting, just start\n"
             << "listing rooms for it to fly through (it can curve). End your list with a blank\n"
             << "line. If your aim is off (eg. cavern 15 cannot actually be reached from cavern\n"
             << "12) then the arrow will randomly fly to another room. If your arrow hits the\n"
             << "wumpus, you win. If the arrow hits you, you lose.\n";
        cout << endl;
        cout << "WARNINGS\n"
             << "You'll be warned if a hazard is nearby.\n"
             << "Wumpus -- You smell a wumpus\n"
             << "Bat -- You hear flapping\n"
             << "Pit -- You feel a draft\n";
        cout << endl;
        cout << "Main Menu (enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');

        return;
    }

    /*-========================================================================/
    void playTurn(void)
    /========================================================================-*/
    void GameManager::playTurn(void) {
        // Here's an outline of what this function does, along with some tags.
        // @LOCATE
        // Inform hunter of location and neighbors.
        // @LISTEN
        // Inform hunter of threats.
        // @CHOOSE
        // Let hunter choose whether to move or shoot
        // @ACT
        // Act on input
        // @AUTOMATE
        // Clean up. If user shot, check for effects of arrow. Check to see if
        // he is now with a bat, pit, or wumpus.

        // dependencies
        using std::cout;
        using std::cin;
        using std::endl;
        using std::cerr;

        // variables
        int i = 0;
        int input = 0;

        // @LOCATE
        // Inform hunter of location and neighbors.
        cout << endl
             << "You are in cave "
             << hunterLocation->getID()
             << endl;
        cout << "You have "
             << arrows
             << " arrows left.\n";
        cout << "Your neighbors are caves";
        for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
            cout << " " << (hunterLocation->getNeighbor(i))->getID();
        }
        cout << endl;

        // @LISTEN
        // Inform hunter of threats.
        // Notify the player only _once_ per threat type.
        for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
            if((hunterLocation->getNeighbor(i))->getBatPresent()) {
                cout << "You hear flapping!\n";
                break;  // equivalent to: i = NUM_OF_THREATS;
            }
        }
        for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
            if((hunterLocation->getNeighbor(i))->getPitPresent()) {
                cout << "You feel a draft!\n";
                break;
            }
        }
        for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
            if((hunterLocation->getNeighbor(i))->getWumpusPresent()) {
                cout << "You smell a wumpus!\n";
                break;
            }
        }

        // @CHOOSE
        // Let hunter choose whether to move or shoot
        do {
            cout << "What would you like to do?\n"
                 << "1) Move\n"
                 << "2) Shoot\n"
                 << "> ";

            if(!(cin >> input)) {
                cin.clear();
                cout << "Whoops -- you'll need to enter a number.\n";
            } else if(1 != input && 2 != input) {
                cout << "Whoops -- you'll need to enter the number 1 or 2.\n";
            }
            cin.ignore(1000, '\n');
        } while(1 != input && 2 != input);

        // @ACT
        // Act on input.
        if(1 == input) {
            // do this while input does not match one of the given options
            do {
                cout << "Where would you like to move?\n";
                // Procedurally list the ID numbers of all neighboring caverns.
                for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
                    cout << i + 1
                         << ") Cave "
                         << (hunterLocation->getNeighbor(i))->getID()
                         << endl;
                }

                if(!(cin >> input)) {
                    cin.clear();
                    cout << "Whoops -- you'll need to enter a number.\n";
                } else if(input <= 0 || input > NUM_OF_NEIGHBORS) {
                    cout << "Whoops -- you'll need to enter the number";
                    for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
                        cout << " " << i + 1;
                    }
                    cout << endl;
                }
                cin.ignore(1000, '\n');
            } while(input <= 0 || input > NUM_OF_NEIGHBORS);
            // cool, valid input has been gotten.

            hunterLocation = hunterLocation->moveHunter(--input);
        } else if(2 == input) {
            arrows--;
            cout << "Enter a list of cave numbers for the arrow to travel through, ending with a\n"
                 << "word (such as \"end\").\n";
            while(cin >> input) {
                arrowPath.push_back(input);
                cin.ignore(1000, '\n');
            }
            cin.clear();
            cin.ignore(1000, '\n');
        } else {
            cerr << "There has been a serious error getting input.\n"
                 << "Exiting due to error.\n";
            exit(1);
        }

        // @AUTOMATE
        // Clean up. If user shot, check for effects of arrow. Check to see if
        // he is now with a bat, pit, or wumpus.

        // If the user elected to shoot, take care of that before anyting else.
        // If the user did _not_ shoot, take care of that below.
        if(arrowPath.size() > 0) {
            arrowLocation = hunterLocation;

            // Sucessively check each location that the arrow should go to.
            for(i = 0; i < arrowPath.size(); i++) {
                // If the arrow's next destination is valid, then move the arrow
                // predictably. If the arrow's destination is not valid, then
                // move the arrow to a random node.
                if(arrowPathValid(i)) {
                    arrowLocation = find(arrowPath[i]);
                } else {
                    arrowLocation = arrowLocation->getRandomNeighbor();
                }

                // If the arrow is in the same cave as either the hunter or
                // wumpus, kill the hunter/wumpus and stop moving the arrow.
                if(arrowLocation == wumpusLocation) {
                    arrowLocation->setWumpusPresent(false);
                    win();
                    break;
                }
                if(arrowLocation == hunterLocation) {
                    arrowLocation->setHunterPresent(false);
                    deathByArrow();
                    break;
                }
            } // arrow done moving

            if(wumpusAlive() && arrows <= 0) {
            // If you've run out of arrows and have not yet killed the wumpus...
                cout << "Oh no! You've run out of arrows. There's no way you can hunt the wumpus now.\n";
                hunterLocation->setHunterPresent(false);
            } else if(wumpusAlive()) {
            // Move the wumpus, if not already dead.
                cout << "The wumpus stirs...\n";
                wumpusLocation = wumpusLocation->moveWumpus();
                if(wumpusLocation == hunterLocation) {
                    hunterLocation->setHunterPresent(false);
                }
            }

            // Clean up.
            arrowPath.resize(0);
            arrowLocation = NULL;
        } else {
        // If the user did _not_ shoot, take care of that case in the following
        // block of code.
            // If the user moved onto a bat, move him around.
            while(hunterLocation->getBatPresent()) {
                hunterLocation = hunterLocation->moveHunter();
                moveByBat();
            }

            // If the user moved or has been dropped onto a pit, kill him.
            if(hunterLocation->getPitPresent()) {
                hunterLocation->setHunterPresent(false);
                deathByPit();
            }

            // If the hunter move or has been dropped onto the wumpus, move
            // the wumpus.
            if(hunterAlive() && (hunterLocation == wumpusLocation)) {
                cout << "The wumpus stirs...\n";
                wumpusLocation = wumpusLocation->moveWumpus();

                // If the hunter and wumpus are in the same cave, kill the hunter.
                if(hunterLocation == wumpusLocation) {
                    hunterLocation->setHunterPresent(false);
                    deathByWumpus();
                }
            }

        }
    }

    /*-========================================================================/
    static int mainMenu(void) const
    /========================================================================-*/
    int GameManager::mainMenu(void) {
        using std::cout;
        using std::cin;
        using std::endl;
        int input = 0;

        // Let the player choose what he wants to do.
        do {
            cout << endl
                 << "Welcome to Hunt The Wumpus! What would you like to do?\n"
                 << "1) Play Game\n"
                 << "2) View Instructions\n"
                 << "3) Exit\n"
                 << "> ";

            if(!(cin >> input)) {
                cin.clear();
                cout << "Whoops -- you'll need to enter a number.\n";
            } else if(1 != input && 2 != input && 3 != input) {
                cout << "Whoops -- you'll need to enter the number 1, 2, or 3.\n";
            }
            cin.ignore(1000, '\n');
        } while(1 != input && 2 != input && 3 != input);

        return input;
    }

    /*-========================================================================/
    bool arrowPathValid(int) const
    /========================================================================-*/
    bool GameManager::arrowPathValid(int pathIndex) {
        using std::cout;

        // Turns out I can't rely on find() to return NULL. Impossible in
        // C++. Instead, I'lljust have to rely on the fact that I know what
        // ID numbers have been assigned to nodes. Totally breaks
        // the principle of encapsulation, but... ok.
        if(arrowPath[pathIndex] > 20 || arrowPath[pathIndex] < 1) {
            return false;
        }

        // Check each of arrowLocation's neighboring nodes. If any neighboring
        // node is the same as what the user asked for, return true.
        for(int i = 0; i < NUM_OF_NEIGHBORS; i++) {
            if(arrowLocation->getNeighbor(i) == find(arrowPath[pathIndex])) {
                // Here's a detailed breakdown of the if statement. First, 
                // sucessively get addresses to each of the arrow's neighboring 
                // nodes. Then, compare each of these nodes to where the arrow
                // should be going. If there's a match, return true. Else, 
                // return false.
                return true;
            }
        }

        // If the user did not correctly specify a location for the arrow to
        // travel to, return false.
        return false;
    }

    /*-========================================================================/
    static void deathByWumpus(void)
    /========================================================================-*/
    void GameManager::deathByWumpus(void) {
        using std::cout;
        using std::endl;
        using std::cin;

        cout << "You step on something squishy.";
        cin;
        cin.ignore(1000,'\n');

        cout << "...";
        cin;
        cin.ignore(1000,'\n');

        cout << "...";
        cin;
        cin.ignore(1000,'\n');

        cout << "NOM NOM NOM! CRUNCH, SCHLEPP, SLOBBER, GLUP, BURP!\n"
             << "The stinky, smelly, horrible wumpus has EATEN YOU UP!\n"
             << "(enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');
    }

    /*-========================================================================/
    static void deathByArrow(void)
    /========================================================================-*/
    void GameManager::deathByArrow(void) {
        using std::cout;
        using std::cin;

        cout << "What sort of hunter does that? You shot yourself!\n"
             << "Better work on your map-making abilities next time.\n"
             << "(enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');
    }

    /*-========================================================================/
    static void deathByPit(void)
    /========================================================================-*/
    void GameManager::deathByPit(void) {
        using std::cout;
        using std::cin;

        cout << "Aaaaiiieee! You've fallen into a pit! (the worms will have a feast tonight)\n"
             << "(enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');
    }

    /*-========================================================================/
    static void moveByBat(void)
    /========================================================================-*/
    void GameManager::moveByBat(void) {
        using std::cout;
        using std::cin;

        cout << "Wheee!\n"
             << "Thank you for using the batty transportation system. Please come again.\n"
             << "(enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');
    }

    /*-========================================================================/
    static void win(void)
    /========================================================================-*/
    void GameManager::win(void) {
        using std::cout;
        using std::cin;

        cout << "Congratulations! You've sucessfully hunted the wumpus! Songs of great renound\n"
             << "will be sung about you for generations to come. Its' meat will feed your tribe\n"
             << "for many moons, and its pelt will make a wonderful and rather strange rug.\n"
             << "(enter)\n"
             << "> ";
        cin;
        cin.ignore(1000,'\n');
    }

    /*-========================================================================/
    DynamicCave* find(int) const
    /========================================================================-*/
    DynamicCave* GameManager::find(int target) {
        using std::cout;

        for(int i = 0; i < MAP_SIZE; i++) {
            if(gameMap[i].getID() == target) {
                return &gameMap[i];
            }
        }

        cout << "Uh oh. Cannot find a node. Exiting.\n";
        exit(1);
    }
}
