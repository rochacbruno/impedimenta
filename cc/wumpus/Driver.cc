#include <cstdlib>
#include <ctime>
#include "GameManager.h"

int main(void) {
    // Dependencies
    using std::srand;
    using JeremyWumpus::GameManager;
    srand(time(NULL));

    // Variables
    GameManager theGame;

    // Setup done. Start body of program.
    theGame.playGame();

    return 0;
}
