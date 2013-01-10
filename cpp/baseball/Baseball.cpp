/*=============================================================================/
Jeremy Audet
Baseball.cpp, for Object Oriented Programming, taught by Mike Soulia
Program includes five files: Baseball.cpp, Team.h, Team.cpp, Player.h, and Player.cpp
Features that program should implement are kept track of in the file "traceability table.odt"
Revision history of program is at bottom of this file.
/============================================================================*/
#include <iostream>
#include <cstdlib>
#include <ctime>
#include "Team.h"
#include "Player.h"
using namespace std;

// use function to generate and show a simulated box score
void showFakeBoxScore(void);
// use function to fill a vector of players
void fillPlayerVector(vector<Player>&, const int NUM_OF_PLAYERS);
// Prompts player to press enter
void genericPrompt(void);

int main(void) {
	/*-====================================================================/
	Setup
	/====================================================================-*/
	srand(time(NULL));		// seeds rand() using time
	vector<Player> sampleRoster;	// this roster is used to fill Team rosters
	const int TEAM_SIZE = 9;	// number of players on each baseball team
	int i = 0;
	Team redSox;
	Team yankees;

	if(TEAM_SIZE < 0) {
		cerr << "TEAM_SIZE must be at least 0. TEAM_SIZE == " << TEAM_SIZE << endl
		     << "Cannot create baseball teams that small. Exiting due to error.\n";
		exit(1);
	}

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(3);

	/*-====================================================================/
	Body of Program
	/====================================================================-*/
	// fill teams with players
	fillPlayerVector(sampleRoster, TEAM_SIZE);
	redSox = Team("Red Sox", sampleRoster);
	fillPlayerVector(sampleRoster, TEAM_SIZE);
	yankees = Team("Yankees", sampleRoster);

	// display red sox team
	cout << "------=====------\n"
	     << "Team Name: " << redSox.getTeamName() << endl
	     << "Team Avg:  " << redSox.getBattingAverage() << endl
	     << "-----------------\n";
	for(i = 0; i < TEAM_SIZE; i++) {
		cout << "Name:    " << redSox.getName(i) << endl
		     << "Number:  " << redSox.getJerseyNumber(i) << endl
		     << "Bat Avg: " << redSox.getBattingAverage(i) << endl;
		if(4 == i % 5) {
			genericPrompt();
		}
	}
	genericPrompt();

	// display yankees team
	cout << endl
	     << "------=====------\n"
	     << "Team Name: " << yankees.getTeamName() << endl
	     << "Team Avg:  " << yankees.getBattingAverage() << endl
	     << "-----------------\n";
	for(i = 0; i < TEAM_SIZE; i++) {
		cout << "Name:    " << yankees.getName(i) << endl
		     << "Number:  " << yankees.getJerseyNumber(i) << endl
		     << "Bat Avg: " << yankees.getBattingAverage(i) << endl;
		if(4 == i % 5) {
			genericPrompt();
		}
	}
	genericPrompt();

	// display sample score from a game
	cout << endl;
	showFakeBoxScore();
	genericPrompt();

	return 0;
}

/*-============================================================================/
Standalone Functions
/============================================================================-*/
void genericPrompt(void) {
	cout << "(enter)\n"
	     << "> ";
	cin;
	cin.ignore(1000,'\n');
}

void fillPlayerVector(vector<Player>& players, const int NUM_OF_PLAYERS) {
	const int NUMBER_OF_NAMES = 30;
	int i = 0;

	if(NUM_OF_PLAYERS < 0) {
		cerr << "fillPlayerVector() must create at least 0 players.\n"
		     << "Attempting to create " << NUM_OF_PLAYERS << " players, which is too few.\n"
		     << "Exiting due to error.\n";
		exit(1);
	}

	const string sampleNames[NUMBER_OF_NAMES] = {
		"Neil Canto",
		"Jessie Kennell",
		"Nelson Stearn",
		"Jerri Deloatch",
		"Tabares",
		"Neil Kuiper",
		"Christian Underdown",
		"Edwina Hail",
		"Max Furniss",
		"Allie Hallberg",
		"Kurt Miga",
		"Fernando Band",
		"Neil Hiltz",
		"Erik Lamorequx",
		"Katy Friddle",
		"Marylout Vanwingerden",
		"Nita Sautter",
		"Guy Schoemaker",
		"Harriett Metivier",
		"Carmella Acoff",
		"Hillary Learned",
		"Avis Wafford",
		"Matthew Delman",
		"Sarron Hennessee",
		"Fernando Wohlers",
		"Melisa Coco",
		"Saundra Jiron",
		"Ted Rolland",
		"Lonnie Smelley",
		"Guy Prestwich"
	};

	players.resize(NUM_OF_PLAYERS);
	for(i = 0; i < NUM_OF_PLAYERS; ++i) {
		players[i].setJerseyNumber(rand() % 100);
		players[i].setBattingAverage( static_cast<double>((rand() % 301 + 100) / 1000.0) );
		players[i].setName(sampleNames[rand() % NUMBER_OF_NAMES]);
	}
}

void showFakeBoxScore(void) {
	int boxScore[2][9];
	int i = 0;
	int totalScore = 0;

	for(i = 0; i < 9; ++i) {
		boxScore[0][i] = rand() % 10;
		boxScore[1][i] = rand() % 10;
	}

	cout << "Team     Inning Scores     Total\n";

	// Home team score
	cout << "Home    ";
	for(i = 0, totalScore = 0; i < 9; ++i) {
		cout << " " << boxScore[0][i];
		totalScore += boxScore[0][i];
	}
	cout << "    " << totalScore << endl;

	// Visitor team score
	cout << "Visitors";
	for(i = 0, totalScore = 0; i < 9; ++i) {
		cout << " " << boxScore[1][i];
		totalScore += boxScore[1][i];
	}
	cout << "    " << totalScore << endl;

	return;
}

/*============================================================================/
REVISION HISTORY

v0.1
10/17/2010
Traceability table created. Baseball.cpp, Team.h, Team.cpp, Player.h, and Player.cpp created. Basic outline of all classes described, though not yet explicitly defined. Program due 10/21/2010.

v0.2
10/17/2010
Class members explicitly declared. Class members not yet defined. main() now seeds rand().

v0.3
10/17/2010
Have defined just about all member functions and functions. The only member function that I have not defined is Team::calcBattingAverage(). The only non-member function I have yet to define is a function to simulate a box score. I have not updated the traceability table. I'll need to do that tomorrow when I have a clearer head.

I've filled in main() and informally tested the functions and objects that I've created. The coolest test I did was setting TEAM_SIZE to ridiculous values and seeing what happened, especially with htop running in a separate terminal window. Seriously. Try setting TEAM_SIZE to 100000 just to see what happens. :)

v1.0
10/17/2010
Finished showFakeBoxScore and Team::calcBattingAverage(). 

v1.1
10/18/2010
Removed "using std::cout;" and "using std::endl;" from Team.cpp, as they are no longer needed. Modified output in main() so that formatting looks better. Created genericPrompt() in main().
/============================================================================*/
