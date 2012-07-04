#ifndef GRAPES_H
#define GRAPES_H

class Grapes {
	public:
		Grapes();

		void incWeight(Grapes&);
		int getWeight(void);
	private:
		int weight;
};

#endif	// #define GRAPES_H
