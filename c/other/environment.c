/*
Print the environment variable EDITOR, if set.
*/
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char * myEnvVar = getenv("EDITOR");

    printf("The EDITOR envionment variable is %s.\n", myEnvVar);

    return 0;
}
