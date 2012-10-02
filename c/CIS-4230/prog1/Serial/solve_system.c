/*!
    \file   solve_system.c
    \brief  Solve a large system of simultaneous equations.
    \author (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
*/

#include <stdlib.h>
#include <stdio.h>
#include <Timer.h>

#include "linear_equations.h"

int main( int argc, char *argv[] )
{
    FILE          *input_file;
    size_t         size;

    if( argc != 2 ) {
        printf( "Error: Expected the name of a system definition file.\n" );
        return EXIT_FAILURE;
    }

    if( (input_file = fopen( argv[1], "r" )) == NULL ) {
        printf("Error: Can not open the system definition file.\n");
        return EXIT_FAILURE;
    }

    // Get the size.
    fscanf( input_file, "%d", &size );

    // Allocate the arrays.
    floating_type a[size][size];
    floating_type b[size];

    // Get coefficients.
    for( size_t i = 0; i < size; ++i ) {
        for( size_t j = 0; j < size; ++j ) {
            fscanf( input_file, "%lf", &a[i][j] );  // Nasty type unsafety!
        }
        fscanf( input_file, "%lf", &b[i] );  // Here too!
    }
    fclose( input_file );

    Timer stopwatch;
    Timer_start( &stopwatch );
    int error;
    gaussian_solve( size, a, b, &error );
    Timer_stop( &stopwatch );

    if( error ) {
        printf( "System is degenerate\n" );
    }
    else {
        printf( "\nSolution is\n" );
        for( size_t i = 0; i < size; ++i ) {
            printf( " x(%4d) = %9.5f\n", i, b[i] );
        }

        printf( "\nExecution time = %ld milliseconds\n", Timer_time( &stopwatch ) );
    }

    return EXIT_SUCCESS;
}
