class Month {
	public:
		Month();
		Month(int);
		Month(char, char, char);

		void setMonthInt(int);
		void setMonthChar(int, int, int);
		int getMonthInt(void);
		void getMonthChar(char&, char&, char&);
	private:
		int month;
};
