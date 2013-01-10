#ifndef PLAYER_H
#define PLAYER_H

#include <string>
using std::string;

class Player {
	public:
		Player();
		/*=============================================================/
		Precondition: none.
		Postcondition: New player object is created with default values. Player batting aveage will, be set between 0.100 and 0.400. Also, player jersey number will be set to -1; this helps identify any objects that have been created but not initialized with reasonable default values.
		/=============================================================*/

		Player(const string newName, const int newJerseyNumber);
		/*=============================================================/
		Precondition: Self-explanatory.
		Postcondition: New player object is created. Batting average will be set between 0.100 and 0.400. This constructor will accept values for the player name and Jersey number without question.
		/=============================================================*/

		string getName(void) const;
		int getJerseyNumber(void) const;
		double getBattingAverage(void) const;
		/*=============================================================/
		Precondition: None.
		Postcondition: Appropriate player stat is returned.
		/=============================================================*/

		void setName(const string newName);
		void setJerseyNumber(const int newJerseyNumber);
		void setBattingAverage(const double newBattingAverage);
		/*-============================================================/
		Precondition: Pass a player name, jersey number, or batting average, respectively. setBattingAverage() will check to make sure that newBattingAverage is between 0.00 and 1.00, inclusive. setJerseyNumber and setName accept whatever values they are handed, without question.
		Postcondition: Appropriate variable is set.
		/============================================================-*/
	private:
		string name;
		int jerseyNumber;
		double battingAverage;
};

#endif // #ifndef PLAYER_H
