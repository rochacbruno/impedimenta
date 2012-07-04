#ifndef DYNAMICSTRINGARRAY_H
#define DYNAMICSTRINGARRAY_H

#include <string>
using std::string;

class DynamicStringArray {
	public:
		int getSize(void) const;
		// Returns size. Easy.

		void addEntry(string);
		/*-============================================================/
		Precondition: Pass addEntry a valid string.
		Postcondition: The string passed will be added to the end ptrString, and size will be incremented.
		/============================================================-*/

		string getEntry(int) const;
		/*-============================================================/
		Precondition: Pass getEntry() a valid int.
		Postcondition: getEntry() will attempt to find a string with that index number in ptrString. If the index number passed is valid, getEntry will return that string. If the index number passed is not valid, getEntry will NOT return NULL, as per instructions. Cannot return that data type. getEntry will return an empty string if the index number passed is not valid.
		/============================================================-*/

		bool deleteEntry(string);
		/*-============================================================/
		Precondition: Pass deleteEntry() a valid string.
		Postconfition: deleteEntry() will search ptrString for the string passed. If a match is found, 1) that entry will be deleted 2) size will be decremented 3) deleteEntry will return true 4) only one entry will be deleted. If more than one entry matches, only the first will be deleted. If deleteEntry does not find a match, then it will return false.
		/============================================================-*/

		DynamicStringArray();	// Constructor. Set ptrString to NULL and size to 0.
		~DynamicStringArray();	// Destructor. Destroys ptrString.
		DynamicStringArray(const DynamicStringArray&);			// Copy Constructor
		DynamicStringArray operator =(const DynamicStringArray&);	// Assignment Operator
	private:
		int size;
		string *ptrString;
};

#endif // #ifndef DYNAMICSTRINGARRAY_H
