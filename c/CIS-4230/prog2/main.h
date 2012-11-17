#include <stdio.h>
#include <stdlib.h> // for malloc() and free()

#include "Initialize.h"
#include "mpi.h" // for MPI functions and constants
#include "Object.h"
#include "Timer.h" // for benchmarking

#define STEPS_PER_YEAR 8766 // Number of hours in a year.
#define STEP_LIMIT 300 // after how many steps should the program stop?
#define ROOT 0 // rank of root process
