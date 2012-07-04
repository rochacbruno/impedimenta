#include <stdio.h>

void main()
{
// declare the variables:
int nNumber;
int *pPointer;

// now, give a value to them:

nNumber = 15;
pPointer = &nNumber;

// print out the value of nNumber:

printf("nNumber is equal to : %d\n", nNumber);

// now, alter nNumber through pPointer:

*pPointer = 25;

// prove that nNumber has changed as a result of the above by
// printing its value again:

printf("nNumber is equal to : %d\n", nNumber);
}
