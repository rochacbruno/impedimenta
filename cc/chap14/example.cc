class SmartBut: public Smart {
	public:
		SmartBut();
		SmartBut(int, int, bool);
		bool isCrazy(void) const;
	private:
		bool crazy;
};
