#ifndef TEAM_H
#define TEAM_H

#include "Player.h"
#include <vector>
using std::vector;
#include <string>
using std::string;

class Team {
	public:
		Team();
		/*-============================================================/
		Precondition: None.
		Postcondition: New team is created. teamName is set to "no team name set". battingAverage set to 0.0, and roster made empty.
		/============================================================-*/
		Team(string newTeamName, vector<Player>& newRoster);
		/*-============================================================/
		Precondition: First argument is the new name for the team. Second argument is a Player vector.
		Postcondition: New team is created. Team name and roster set according to arguments given. Team batting average will be set according to the Player vector passed.
		/============================================================-*/

		string getTeamName(void) const;
		double getBattingAverage(void) const;
		/*-============================================================/
		Precondition: None.
		Postcondition: Appropriate team stat is returned.
		/============================================================-*/

		string getName(int) const;
		int getJerseyNumber(int) const;
		double getBattingAverage(int) const;
		/*-============================================================/
		Precondition: Int argument is the number of the team member you want to know about.
		Postcondition: Appropriate player stat is returned.
		/============================================================-*/
	private:
		string teamName;
		double battingAverage;
		vector<Player> roster;

		void calcBattingAverage(void);
		/*-============================================================/
		Precondition: None.
		Postcondition: Member function will both calculate AND SET a value for battingAverage. To calculate a value for battingAverage, calcBattingAverage() will examine all of the players in the object roster. The average player batting average will be used to set the batting average for the team. Any time the team roster is changed, or an individual player batting average changes, you may want to call this function.
		/============================================================-*/
};

#endif //#ifndef TEAM_H
