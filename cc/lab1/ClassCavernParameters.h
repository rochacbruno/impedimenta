/*-----------------------------------------------------------------------------/
CavernParameters:: defines what a cavern is. Keeps tracks of things like whether a bat is present and who the neighbor caverns are. CavernParameters:: also gives functions to check and set whether an item is present.
/-----------------------------------------------------------------------------*/
#ifndef CLASSCAVERNPARAMETERS_H
#define CLASSCAVERNPARAMETERS_H
class CavernParameters {
	public:
		void setNeighborCaverns(int, int, int);
		/*-------------------------------------------------------------/
		Precondition: Each number that you give to setNeighborCaverns represents one neighboring cavern. 
		Postcondition: Private vars neighborCavern1, neighborCavern2, and neighborCavern3 will be set. Your object of type CavernParameters now has neighboring caverns. Do this intelligently for all your caverns, and you have a map.
		/-------------------------------------------------------------*/

		void getNeighborCaverns(int*);
		/*-------------------------------------------------------------/
		Precondition: Give getNeighborCaverns an array with three members that it can manipulate.
		Postcondition: getNeighborCaverns will fill the array with numbers that correspond to the index number of each neighboring cavern. If you setNeighborCaverns(2,6,5), then int[] = {2,6,5};
		/-------------------------------------------------------------*/

		void setBatIsPresent(bool);
		void setPitIsPresent(bool);
		void setHunterIsPresent(bool);
		void setWumpusIsPresent(bool);
		/*-------------------------------------------------------------/
		Precondition: If passed non-zero value, thebat/pit/hunter/wumpus will be marked as present. If passed a 0, thing will be marked as not present.
		Postcondition: bool bat/pit/hunter/wumpus will be set to the same value as what was passed.
		/-------------------------------------------------------------*/

		bool getBatIsPresent(void);
		bool getPitIsPresent(void);
		bool getHunterIsPresent(void);
		bool getWumpusIsPresent(void);
		bool getThreatIsPresent(void);
		bool getAnythingIsPresent(void);
		/*-------------------------------------------------------------/
		Precondition: none
		Postcondition: returns a 1 if item is present, 0 if not
		/-------------------------------------------------------------*/
	private:
		bool bat;
		bool pit;
		bool hunter;
		bool wumpus;
		int neighborCavern1;
		int neighborCavern2;
		int neighborCavern3;
};
#endif	// #ifndef CLASSCAVERNPARAMETERS_H
