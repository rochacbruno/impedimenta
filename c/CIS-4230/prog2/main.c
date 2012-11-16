/*! \file    main.c
    \brief   Main program of the serial solar system simulator.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

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
#define ROOT 0 // rank of root process
#define STEPS_LIMIT 300 // after how many steps should the program stop?

main(int argc, char ** argv) {
    // MPI initialization
    int my_rank; // Rank   of process
    int n_procs; // Number of processes
    MPI_Init(&argc, &argv);                  // Launch MPI processes on nodes
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank); // get rank from MPI master process
    MPI_Comm_size(MPI_COMM_WORLD, &n_procs); // get number of MPI processes

    // other prep work
    Timer stopwatch;
    Timer_initialize(&stopwatch);
    long total_steps = 0;
    initialize_object_arrays();
    // dump_dynamics(); // only have root print this?
    if(ROOT == my_rank) {
        printf("Number of MPI processes = %d\n", n_procs);
        printf("Starting stopwatch.\n");
        Timer_start(&stopwatch);
    }

    // do an n-body simulation!
    while(STEPS_LIMIT > total_steps) {
        time_step();
        total_steps++;
    }

    // clean-up work
    if(ROOT == my_rank) {
        Timer_stop(&stopwatch);
        printf("Years simulated = %.3lf\n", (double)total_steps / (double)STEPS_PER_YEAR);
        printf("Time steps = %d\n", total_steps);
        printf("Time elapsed = %ld milliseconds\n", Timer_time(&stopwatch));
        fflush(stdout);
    }
    // dump_dynamics();
    MPI_Finalize();
} // main
