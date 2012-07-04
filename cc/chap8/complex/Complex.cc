#include "Complex.h"
#include <iostream>
using namespace std;

/*=============================================================================/
Constructors
/=============================================================================*/
Complex::Complex() {
	real = 0;
	imaginary = 0;

	return;
}

Complex::Complex(double realPart) {
	real = realPart;
	imaginary = 0;

	return;
}

Complex::Complex(double realPart, double imaginaryPart) {
	real = realPart;
	imaginary = imaginaryPart;

	return;
}

/*=============================================================================/
Normal Member Functions
/=============================================================================*/
double Complex::getReal(void) const {
	return real;
}

double Complex::getImaginary(void) const {
	return imaginary;
}

/*=============================================================================/
Operator Member Functions
/=============================================================================*/
// Try leaving out Complex:: namespace specifier
const Complex Complex::operator +(const Complex& number2) const {
	double realResult = real + number2.real;
	double imaginaryResult = imaginary + number2.imaginary;

	return Complex(realResult, imaginaryResult);
}

// Because this is outside of the Complex namespace, getters must be used.
const Complex operator -(const Complex& number1, const Complex& number2) {
	double realResult = number1.getReal() - number2.getReal();
	double imaginaryResult = number1.getImaginary() - number2.getImaginary();

	return Complex(realResult, imaginaryResult);
}

const Complex operator *(const Complex& number1, const Complex& number2) {
	double realResult = (number1.real * number2.real) - (number1.imaginary * number2.imaginary);
	double imaginaryResult = (number1.real * number2.imaginary) + (number1.imaginary * number2.real);

	return Complex(realResult, imaginaryResult);
}

bool Complex::operator ==(const Complex& number2) const {
	if(real == number2.real && imaginary == number2.imaginary) {
		return true;
	} else {
		return false;
	}
}

istream& operator >>(istream& inputStream, Complex& number) {
	while(!(inputStream >> number.real)) {
		cout << "Need double for real part of number.\n";
		inputStream.clear();
		inputStream.ignore(1000,'\n');
	}
	inputStream.ignore(1000,'\n');

	while(!(inputStream >> number.imaginary)) {
		cout << "Need double for imaginary part of number.\n";
		inputStream.clear();
		inputStream.ignore(1000,'\n');
	}
	inputStream.ignore(1000, '\n');

	return inputStream;
}

ostream& operator <<(ostream& outputStream, const Complex& number) {
	outputStream << number.real
		<< " + "
		<< number.imaginary
		<< "*i";

	return outputStream;
}
