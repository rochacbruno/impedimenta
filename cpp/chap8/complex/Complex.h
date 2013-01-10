#ifndef COMPLEX_H
#define COMPLEX_H

#include <iostream>

class Complex {
	public:
		// constructors
		Complex();
		Complex(double realPart);
		Complex(double realPart, double imaginaryPart);

		// member functions
		double getReal(void) const;
		double getImaginary(void) const;

		// operators
		const Complex operator +(const Complex& number2) const;					// member function
		friend const Complex operator *(const Complex& number1, const Complex& number2);	// friend function
		bool operator ==(const Complex& number2) const;						// member function
		friend std::istream& operator >>(std::istream& inputStream, Complex& number);		// friend function
		friend std::ostream& operator <<(std::ostream& outputStream, const Complex& number);	// friend function
		// const Complex Complex::operator +(const Complex& number2) const;
		// Because this declaration is inside the Complex class, the Complex:: namespace tag (qualifier? identifier? specifier?) is unnecessary. 
		// Addition declaration uses const three times in three different contexts. The first and last const apply to the member function declaration, and the middle const applies to a pointer. The first const says that the value of the Complex object that is returned cannot be changed. The last const says that this member function cannot change the values of anything else in this class. The middle const says that the values of the object being passed in cannot be changed.
		// Because this function is defined as a friend to the class Complex, it has access to all members (both values and functions) of Complex objects. Notice that the declaration of this function looks a lot like the declaration of a member function. There are two differences: a) the keyword friend has been added to the function declaration b) the Complex:: class specifier is not present in the function definition (as the function truly does not belong to the class, it is only a friend).
	private:
		double real;
		double imaginary;
};

const Complex operator -(const Complex& number1, const Complex& number2);				// nonmember function

#endif // #ifndef COMPLEX_H
