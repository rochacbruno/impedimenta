/*!
    \file   solve_system.c
    \brief  Solve a large system of simultaneous equations.
    \author (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
*/

#include <stdlib.h>
#include <stdio.h>
#include <Timer.h>
#include "linear_equations.h"

int main(int argc, char * argv[]) {
    FILE * input_file;
    int size;

    // Check for arg and validity of that arg.
    if(argc != 2) {
        printf("Error: Expected the name of a system definition file.\n");
        return EXIT_FAILURE;
    }
    if((input_file = fopen(argv[1], "r")) == NULL) {
        printf("Error: Can not open the system definition file.\n");
        return EXIT_FAILURE;
    }

    // Get the size of the gaussian equation, then create arrays to hold it.
    // WARNING: this should be malloc'd. Creating a[size][size] results in
    // segfaults for large ``size``. (on my machine, 1100+ will do it)
    fscanf(input_file, "%d", &size);
    floating_type * a = malloc(size * size * sizeof(floating_type));
    floating_type * b = malloc(size * sizeof(floating_type));
    // Populate arrays with coefficients.
    for(int row = 0; row < size; ++row) {
        for(int col = 0; col < size; ++col) {
            fscanf(input_file, "%lf", &a[row * size + col]); // Nasty type unsafety!
        }
        fscanf(input_file, "%lf", &b[row]); // Here too!
    }
    fclose(input_file);

    // Solve the equation.
    Timer stopwatch;
    Timer_start(&stopwatch);
    int error;
    gaussian_solve(size, a, b, &error);
    Timer_stop(&stopwatch);

    // Print the solution.
    if(error) {
        printf("System is degenerate\n");
    } else {
        printf("\nSolution is\n");
        for(int i = 0; i < size; ++i) {
            printf(" x(%4d) = %9.5f\n", i, b[i]);
        }
        printf("\nExecution time = %ld milliseconds\n", Timer_time(&stopwatch));
    }

    free(a);
    free(b);

    return EXIT_SUCCESS;
}
