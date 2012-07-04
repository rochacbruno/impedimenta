#ifndef GRAPES_H
#define GRAPES_H

class Grapes {
	public:
		Grapes();
		Grapes(int);
		Grapes(int, int);

		void getAll(void);
		void increment(void);
		static Grapes returnObject(Grapes&);
	private:
		int grapesPerVine;
		int Vines;
};

#endif	// #ifndef GRAPES_H
