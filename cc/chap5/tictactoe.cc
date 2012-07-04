#include <iostream>
#include <cstdlib>
using namespace std;

bool checkForWinner(const int game[][3], int tag);
// Tag: The value I am checking for. In this game, either -1 or -2.

int main(void) {
	bool validInput;	// Flag. Is userInputInt or userInputChar valid?
	bool winner;
	char userInputChar;
	int userInputInt;
	int player;		// -1 refers to player 1, -2 for player 2
	int row;
	int column;
	int plays;
	int board[3][3] =
	{
		{1, 2, 3},
		{4, 5, 6},
		{7, 8, 9}	// This is what the board will be reset to every
	};	// time a new game is started.

	do {
		// SETUP
		board[0][0] = 1;
		board[0][1] = 2;
		board[0][2] = 3;
		board[1][0] = 4;
		board[1][1] = 5;
		board[1][2] = 6;
		board[2][0] = 7;
		board[2][1] = 8;
		board[2][2] = 9;
		player = 2;
		plays = 0;

		// PLAY GAME
		do {
			// figure out who the current player is
			if(2 == player) {
				player = 1;
			} else {
				player = 2;
			}
			cout << "   Player "
			     << player
			     << endl;
			cout << "  ----===----\n";

			// show board
			// output lines
			for(column = 0; column < 3; column++) {
				cout << "     ";
				// output single board locations
				for(row = 0; row < 3; row++) {
					if(-1 == board[column][row]) {
						cout << "X ";
					} else if(-2 == board[column][row]) {
						cout << "O ";
					} else {
						cout << board[column][row]
						     << " ";
					}
				}
				cout << endl;
			}
			cout << endl;

			// Get valid input from user. Where to play next move?
			do {
				row = 0;
				column = 0;
				validInput = 1;

				cout << "Where do you want to play?\n"
				     << "> ";
				if(!(cin >> userInputInt)) {
					cout << "You need to input a number, not a letter!\n";
					cin.clear();
					cin.ignore(1000,'\n');
					validInput = 0;
				} else if(1 > userInputInt || 9 < userInputInt) {
					cout << "You'll need to plug in a number from 1 to 9.\n";
					cin.clear();
					cin.ignore(1000,'\n');
					validInput = 0;
				}

				if(1 == validInput) {
					column = (userInputInt - 1) / 3;
					row = (userInputInt - 1) % 3;

					if(1 > board[column][row]) {
						cout << "Someone has already played there!\n";
						validInput = 0;
					}
				}
			} while(0 == validInput);
			cout << endl;

			// Input has been gotten. Write changes out.
			if(1 == player) {
				board[column][row] = -1;
			} else {
				board[column][row] = -2;
			}

			// check for winner
			winner = checkForWinner(board, (player * -1));
			plays++;
		} while(0 == winner && 9 > plays);

		// Game has finished. Spit out appropriate message.
		if(1 == winner) {
			cout << "Congratulations, Player "
			     << player
			     << "!\n"
			     << "You have won!\n"
			     << endl;
		} else {
			cout << "Tie! No player wins!\n"
			     << endl;
		}

		// PLAY AGAIN?
		cout << "Do you want to play tic tac toe again?\n"
		     << "Yes (y) No (n)\n"
		     << "> ";
		while(!(cin >> userInputChar) || ('y' != userInputChar && 'n' != userInputChar)) {
			cout << endl;
			cin.clear();
			cin.ignore(1000,'\n');
			cout << "I'll need either a 'y' or a 'n'.\n"
			     << "Do you want to play tic tac toe again?\n"
			     << "Yes (y) No (n)\n"
			     << "> ";
		}
		cin.ignore(1000,'\n');
		cout << endl;
	} while('y' == userInputChar);

	return 0;
}

bool checkForWinner(const int game[][3], int tag) {
	// game[column][row]

        if/*---*/(tag == game[0][0] && tag == game[0][1] && tag == game[0][2]) {
		return 1;
	} else if(tag == game[1][0] && tag == game[1][1] && tag == game[1][2]) {
		return 1;
	} else if(tag == game[2][0] && tag == game[2][1] && tag == game[2][2]) {
		return 1;
	} else if(tag == game[0][0] && tag == game[1][0] && tag == game[2][0]) {
		return 1;
	} else if(tag == game[0][1] && tag == game[1][1] && tag == game[2][1]) {
		return 1;
	} else if(tag == game[0][2] && tag == game[1][2] && tag == game[2][2]) {
		return 1;
	} else if(tag == game[0][0] && tag == game[1][1] && tag == game[2][2]) {
		return 1;
	} else if(tag == game[0][2] && tag == game[1][1] && tag == game[2][0]) {
		return 1;
	}

	return 0;
}
