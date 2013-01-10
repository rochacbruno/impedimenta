// Notes at bottom of program. More notes in Complex.h.
#include <iostream>
#include "Complex.h"
using namespace std;

int main(void) {
	Complex num1(5.0, 6.6), num2(3.14159, 0.0), result;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(2);

	cout << "num1 = "
	     << num1.getReal()
	     << " + "
	     << num1.getImaginary()
	     << "*i\n";
	cout << "num2 = "
	     << num2.getReal()
	     << " + "
	     << num2.getImaginary()
	     << "*i\n";

	result = num1 + num2;
	cout << "num1 + num2 = "
	     << result.getReal()
	     << " + "
	     << result.getImaginary()
	     << "*i\n";
	result = num1 - num2;
	cout << "num1 - num2 = "
	     << result.getReal()
	     << " + "
	     << result.getImaginary()
	     << "*i\n";
	result = num1 * num2;
	cout << "num1 * num2 = "
	     << result.getReal()
	     << " + "
	     << result.getImaginary()
	     << "*i\n";
	cout << "num1 == num2 = "
	     << (num1 == num2)
	     << endl;
	cout << "Complex(987.65, 432.10).getReal(); = "
	     << Complex(987.65, 432.10).getReal()
	     << endl;
	result = num1 * 3.0;
	cout << "num1 * 3.0 = "
	     << result.getReal()
	     << " + "
	     << result.getImaginary()
	     << "*i\n";
	cout << "num1 = "
	     << num1
	     << endl
	     << "num2 = "
	     << num2
	     << endl;
	cin >> num1 >> num2;
	cout << "num1 = "
	     << num1
	     << endl
	     << "num2 = "
	     << num2
	     << endl;

	return 0;
}

/*
It is best not to overload ||, &&, or ,. The overloaded || and && do not perform short-circuit evaluation, as the built-in && and || do. The overloaded , does not guarantee left-to-right evaluation, as the built-in , operator does.

The function call operator () can be overloaded. However, it must be overloaded as a member function. This allows you to use an object as if it was a function. This is similar to how Constructors allow you to use class names as functions. Thus far, I have learned three contexts for using the function call operator: when calling a function, when calling a constructor, and when using an object as a function.

If an operator is declared outside of a class, it does not and cannot belong to that class namespace. If an overloaded operator is declared inside of a class, it does and must belong to that class namespace. This means that operators which are declared as part of a class have access to the private variables of ALL objects of that class type. Operators not declared as part of a class must access private members of an object using getters.

Why declare an operator as a member of a class or not as a member of a class? Declaring an operator as a member of a class means that you can directly access all of the members of an object, including private variables, constants, and functions. Therefore, member operators (operators that are a member of a class) do not need to use accessors or mutators. So why declare an operator that does not belong to a class? The answer has to do with how operators take arguments.

A binary operator that belongs to a class has only one argument, while a binary operator that does not belong to a class has two arguments. If the operator + was declared as belonging to class Money, then in the statement myMoney + yourMoney; myMoney is the calling object and yourMoney is the argument. If the operator + was declared as not belonging to any class, then in the statement myMoney + yourMoney; myMoney and yourMoney are both arguments to the + operator.

Therefore, a binary operator that does not belong to a class can perform automatic type conversion on both the right and left arguments. A binary operator that does belong to a class can perform automatic type conversion on only the right argument.
*/
