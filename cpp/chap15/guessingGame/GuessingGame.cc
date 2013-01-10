/*-============================================================================/
Jeremy Audet, for Object Oriented Programming, taught by Mike Soulia.

This program is ripped straight out of the book, from chapter 15. It implements practice problems 5 and 6. The point of this program is to demonstrate inheritance (HumanPlayer and AIPlayer), polymorphism (getGuess()), and vectors (the Player and Number objects).

This is a number guessing game. Two players are each given a random number between 0 and 100, inclusive. They then compete to see who can guess the random number first. The two players can be either human or AI controlled. Both human and AI objects have some common abilities, such as the ability to make a guess at the random number, and the ability to receive information about whether their last guess was correct or not. By these means, all Player objects are guaranteed some basic level of intelligence.

Each player keeps track of a range. That range describes what the random number could be. For example, if the bottom of the range is 60 and the top of the range is 71, then the random number assigned to that player could be anywhere between 60 and 71, inclusive. By feeding each player information about whether their last guess was too high or too low, the limits of this range are updated automatically. Each type of player (such as human or AI-controlled) is free to use this information however they wish.

For this reason, Player::getGuess() is implemented as a pure virtual function. A HumanPlayer and AIPlayer object will each make a guess making drastically different means. For example, an AIPlayer might examine its range and use an algorithm to decide what number to guess; a HumanPlayer object will simply read in information from the keyboard.

Here's a quick diagram of the classes used in this program:
Player
    HumanPlayer
    AIPlayer
Number

HumanPlayer and AIPlayer are both descended from Player. From the discussion above, it should be pretty obvious what they do. Note that Player is a pure virtual class. I have not yet discussed the Number class.

The Number class simply holds a random number between 0 and 100. It is a pretty small class, and it offers little functionality. You can tell an object of this type to generate a new random number, you can check to see whether a particular guess is too low or high, and you can get the random number directly.

In my main program, Players (of various types) and Numbers are instantiated as vectors. This allows one to create and delete them depending upon which game mode is selected.

The real virtue of the Number class is that it separates players from their goal. This allows you to set up game types a little more freely. For example, you can make a single number that all players attempt to guess. Or you could make a three-player mode where two players get to collaboratively guess at a number, and the third player attempts to beat the other two at it. This division of labor also helps to clearly distinguish between players and their goal. Forcing a player to both guess at a number _and_ know what that number is seems like bad design. 

Finally. I've designed this program with a couple of artifical limitations in mind. Firstly: the random number is between 0 and 100. Secondly: two players are playing at all times. There is no single player mode, for example. Thirdly: the goal of each player is to guess a number (as opposed to, say, guessing at a word).
/============================================================================-*/
#include "HumanPlayer.h"
#include "ComputerPlayer.h"
#include "Number.h"
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>

// Unnamed namespace -- helper functions
namespace {
    void showMenu(void) {
        using std::cout;

        cout << "What would you like to do?\n";
        cout << "--------------------------\n";
        cout << "1) Play Human vs Human\n";
        cout << "2) Play Human vs AI\n";
        cout << "3) Play AI vs AI\n";
        cout << "4) Quit\n";
        cout << "> ";   

        return;
    }
}

// Main program
int main(void) {
    using JeremysCode::HumanPlayer;
    using JeremysCode::ComputerPlayer;
    using JeremysCode::Number;
    using std::vector;
    using std::cout;
    using std::endl;
    using std::cin;
    srand(time(NULL));  // rand() is used in Number and ComputerPlayer objects.

    int input = 0; // used for user input, such as menu coices and number guesses
    int result = 0; // keep track of whether player guesses are high, low, correct
    vector<Number> goal;
    vector<HumanPlayer> humanPlayers;
    vector<ComputerPlayer> AIPlayers;

    // setup done. start main game.
    while(1) {
        // show the menu and grab valid input
        showMenu();
        while(!(cin >> input)) {
            cin.clear();
            cin.ignore(1000, '\n'); 

            cout << "Oops -- I need you to enter a number! Try again.\n";
            cout << "> ";
        }
        cin.ignore(1000, '\n');

        // It's pretty safe to assume that only two people are playing. If the 
        // game ever gets reworked to allow more or less than two players, then
        // move this chunk of code into the actual games.
        goal.resize(2);
        // make sure that new random numbers are calculated before a new game begins
        goal[0].setNumber();
        goal[1].setNumber();
        // make sure that somebody will be able to play (result != 0, no winner)
        result = 1;

        /*-====================================================================/
        Act upon the user's input. Either start a game or quit the program.
        If input was a 1, start a human vs human game.
        /====================================================================-*/
        if(1 == input) {
            humanPlayers.resize(2);
            AIPlayers.resize(0);
            humanPlayers[0].resetLimits();
            humanPlayers[1].resetLimits();

            do {
                /*-============================================================/
                Player 1's turn (human vs human game)
                /============================================================-*/
                if(0 != result) {
                    // show current player and current suggested guess limits
                    cout << endl
                         << "Player 1's turn.\n"
                         << "Lowest possible number:  " << humanPlayers[0].getLow() << endl
                         << "Highest possible number: " << humanPlayers[0].getHigh() << endl;

                    // let player make a guess
                    input = humanPlayers[0].getGuess();

                    // check to see whether player guess was correct
                    result = goal[0].compareNumber(input);
                    
                    // feed that info to appropriate players
                    humanPlayers[0].givePlay(input, result);

                    // show results of turn
                    cout << "Result of turn: ";
                    if(result < 0)      {cout << "Guess too low.\n";} 
                    else if(result > 0) {cout << "Guess too high.\n";} 
                    else                {cout << "Player 1 wins!\n";}

                    // wait...
                    cout << "(enter)\n";
                    cout << "> ";
                    cin;
                    cin.ignore(1000, '\n');
                }

                /*-============================================================/
                Player 2's turn (human vs human game)
                /============================================================-*/
                if(0 != result) {
                    // show current player and current suggested guess limits
                    cout << endl
                         << "Player 2's turn.\n"
                         << "Lowest possible number:  " << humanPlayers[1].getLow() << endl
                         << "Highest possible number: " << humanPlayers[1].getHigh() << endl;

                    // let player make a guess
                    input = humanPlayers[1].getGuess();

                    // check to see whether the player's guess was correct
                    result = goal[1].compareNumber(input);

                    // feed that info to approriate players
                    humanPlayers[1].givePlay(input, result);                

                    // show results of turn
                    cout << "Result of turn: ";
                    if(result < 0)      {cout << "Guess too low.\n";} 
                    else if(result > 0) {cout << "Guess too high.\n";} 
                    else                {cout << "Player 2 wins!\n";}

                    // wait...
                    cout << "(enter)\n";
                    cout << "> ";
                    cin;
                    cin.ignore(1000, '\n');
                }
            } while(0 != result); // keep playing until a winner is found
        /*-====================================================================/
        If input was a 2, start a human vs AI game.
        /====================================================================-*/
        } else if(2 == input) {
            humanPlayers.resize(1);
            AIPlayers.resize(1);
            humanPlayers[0].resetLimits();
            AIPlayers[0].resetLimits();

            do {
                /*-============================================================/
                Player 1's turn (human vs AI game)
                /============================================================-*/
                if(0 != result) {
                    // show current player and current suggested guess limits
                    cout << endl
                         << "Player 1's turn.\n"
                         << "Lowest possible number:  " << humanPlayers[0].getLow() << endl
                         << "Highest possible number: " << humanPlayers[0].getHigh() << endl;

                    // let player make a guess
                    input = humanPlayers[0].getGuess();

                    // check to see whether player guess was correct
                    result = goal[0].compareNumber(input);
                    
                    // feed that info to appropriate players
                    humanPlayers[0].givePlay(input, result);

                    // show results of turn
                    cout << "Result of turn: ";
                    if(result < 0)      {cout << "Guess too low.\n";} 
                    else if(result > 0) {cout << "Guess too high.\n";} 
                    else                {cout << "Player 1 wins!\n";}

                    // wait...
                    cout << "(enter)\n";
                    cout << "> ";
                    cin;
                    cin.ignore(1000, '\n');
                }

                /*-============================================================/
                Player 2's turn (human vs AI game)
                /============================================================-*/
                if(0 != result) {
                    // show current player and current suggeste guess limits
                    cout << endl
                         << "Player 2's turn (AI).\n"
                         << "Lowest possible number: " << AIPlayers[0].getLow() << endl
                         << "Highest possible number: " << AIPlayers[0].getHigh() << endl;

                    // let computer make a guess
                    input = AIPlayers[0].getGuess();
                     cout << "Guess: " << input << endl;

                    // check to see whether player guess was correct
                    result = goal[1].compareNumber(input);

                    // feed results to appropriate players
                    AIPlayers[0].givePlay(input, result);

                    // show results of turn
                    cout << "Result of turn: ";
                    if(result < 0)      {cout << "Guess too low.\n";} 
                    else if(result > 0) {cout << "Guess too high.\n";} 
                    else                {cout << "Player 2 wins!\n";}

                    // wait...
                    cout << "(enter)\n";
                    cout << "> ";
                    cin;
                    cin.ignore(1000, '\n');
                }
            } while(0 != result);
        /*-====================================================================/
        If input was a 3, start an AI vs AI game.
        /====================================================================-*/
        } else if(3 == input) {
            humanPlayers.resize(0);
            AIPlayers.resize(2);
            AIPlayers[0].resetLimits();
            AIPlayers[1].resetLimits();

            do {
                /*-============================================================/
                Player 1's turn (AI vs AI game)
                /============================================================-*/
                if(0 != result) {
                    // show current player and current suggeste guess limits
                    cout << endl
                         << "Player 1's turn (AI).\n"
                         << "Lowest possible number: " << AIPlayers[0].getLow() << endl
                         << "Highest possible number: " << AIPlayers[0].getHigh() << endl;

                    // let computer make a guess
                    input = AIPlayers[0].getGuess();
                     cout << "Guess: " << input << endl;

                    // check to see whether player guess was correct
                    result = goal[0].compareNumber(input);

                    // feed results to appropriate players
                    AIPlayers[0].givePlay(input, result);

                    // show results of turn
                    cout << "Result of turn: ";
                    if(result < 0)      {cout << "Guess too low.\n";} 
                    else if(result > 0) {cout << "Guess too high.\n";} 
                    else                {cout << "Player 1 wins!\n";}

                    // wait...
                    cout << "(enter)\n";
                    cout << "> ";
                    cin;
                    cin.ignore(1000, '\n');
                }

                /*-============================================================/
                Player 2's turn (AI vs AI game)
                /============================================================-*/
                if(0 != result) {
                    // show current player and current suggeste guess limits
                    cout << endl
                         << "Player 2's turn (AI).\n"
                         << "Lowest possible number: " << AIPlayers[1].getLow() << endl
                         << "Highest possible number: " << AIPlayers[1].getHigh() << endl;

                    // let computer make a guess
                    input = AIPlayers[1].getGuess();
                     cout << "Guess: " << input << endl;

                    // check to see whether player guess was correct
                    result = goal[1].compareNumber(input);

                    // feed results to appropriate players
                    AIPlayers[1].givePlay(input, result);

                    // show results of turn
                    cout << "Result of turn: ";
                    if(result < 0)      {cout << "Guess too low.\n";} 
                    else if(result > 0) {cout << "Guess too high.\n";} 
                    else                {cout << "Player 2 wins!\n";}

                    // wait...
                    cout << "(enter)\n";
                    cout << "> ";
                    cin;
                    cin.ignore(1000, '\n');
                }
            } while(0 != result);
        /*-====================================================================/
        Menu option 4
        /====================================================================-*/
        } else if(4 == input) {
            return 0;
        /*-====================================================================/
        Default menu option
        /====================================================================-*/
        } else { 
            cout << "Invalid input: " << input << " is not a menu option.\n";
            cout << endl;
        }
        cout << endl; // add a space before showing the menu again
    } // main game, including menu selection. all setup is performed before this loop
} // main()
