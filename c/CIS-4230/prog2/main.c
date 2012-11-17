/*! \file    main.c
    \brief   Main program of the serial solar system simulator.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

When benchmarking, search for and comment out lines or blocks of code marked
with the word BENCHMARK.

LICENSE

This program is free software; you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if
not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA
*/

#include <stdio.h>
#include <stdlib.h>

#include "Initialize.h"
#include "mpi.h"
#include "Object.h"
#include "Timer.h"

#define STEPS_PER_YEAR 8766 // Number of hours in a year.
#define STEP_LIMIT 300 // after how many steps should the program stop?
#define ROOT 0 // rank of root process

// Initializes MPI, stopwatch, and objects to be simulated. Calls simulation
// functions. Prints out stats to user.
int main(int argc, char ** argv) {
    // MPI initialization
    int my_rank; // Rank   of process
    int n_procs; // Number of processes
    MPI_Init(&argc, &argv);                  // Launch MPI processes on nodes
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank); // get rank from MPI master process
    MPI_Comm_size(MPI_COMM_WORLD, &n_procs); // get number of MPI processes

    // Prep work on solar system.
    initialize_object_arrays();
    // dump_dynamics(); // only have root print this?

    // Create benchmarks.
    Timer stopwatch_self;
    Timer stopwatch1;
    Timer stopwatch2;
    Timer_initialize(&stopwatch1);
    Timer_initialize(&stopwatch2);
    Timer_initialize(&stopwatch_self);
    if(ROOT == my_rank) {
        printf("Number of MPI processes = %d\n", n_procs);
        printf("Starting stopwatch_self.\n");
        Timer_start(&stopwatch_self);
    }

    // do an n-body simulation!
    long long total_steps;
    for(total_steps = 0; STEP_LIMIT > total_steps; total_steps++) {
        time_step(
            n_procs,
            my_rank,
            &stopwatch1,
            &stopwatch2
        );
        if(ROOT == my_rank && 0 == total_steps % 100) { // BENCHMARK
            printf("time steps = %lld\n", total_steps);
        }
    }

    // Allow all processes to print benchmark info.
    if(ROOT == my_rank) {
        Timer_stop(&stopwatch_self);
        printf("Stopwatch stopped.\n");
        printf("Total time elapsed = %ld milliseconds\n", Timer_time(&stopwatch_self));
        printf("Years simulated = %.3Lf\n", (long double)total_steps / (long double)STEPS_PER_YEAR);
        printf("Total time steps = %lld\n", total_steps);
    }
    printf("process %d stopwatch1 = %ld milliseconds\n", my_rank, Timer_time(&stopwatch1));
    printf("process %d stopwatch2 = %ld milliseconds\n", my_rank, Timer_time(&stopwatch2));
    fflush(stdout);

    // dump_dynamics();
    MPI_Finalize();
    return 0;
} // main
