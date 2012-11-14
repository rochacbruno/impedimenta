// To compile and run:
// mpicc -o main main.c
// mpirun -np 4 ./main

#include <stdio.h>
#include "mpi.h"

main(int argc, char ** argv) {
    int my_rank;        // Rank of process
    int p;              // Number of processes
    int source;         // Rank of sender
    int dest;           // Rank of receiver
    int tag = 50;       // Tag for messages
    char message[100];  // Storage for the message
    MPI_Status status;  // Return status for receive

    // Launch MPI processes on each node
    MPI_Init(&argc, &argv);
    // Request a rank (also: thread id, tid) from the MPI master process, whose
    // rank == 0
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    // Get the number of processes launched by MPI.
    MPI_Comm_size(MPI_COMM_WORLD, &p);

    // All processes > 0 send messages to processes 0.
    if(0 != my_rank) {
        sprintf(message, "Greeting from process %d!", my_rank);
        dest = 0;
        MPI_Send(
            message,
            strlen(message) + 1, // +1 to include '\0'
            MPI_CHAR,
            dest,
            tag,
            MPI_COMM_WORLD
        );
    } else {
        for(source = 1; source < p; source++) {
            MPI_Recv(message,
                100,
                MPI_CHAR,
                source,
                tag,
                MPI_COMM_WORLD,
                &status
            );
            printf("%s\n", message);
        }
    }

    MPI_Finalize();
} // main
