// To compile and run:
// mpicc -o main main.c
// mpirun -np 4 ./main

#include <stdio.h>
#include "mpi.h"

#define MSG_LEN 100

main(int argc, char ** argv) {
    int my_rank;        // Rank of process
    int n_procs;        // Number of processes
    int source;         // Rank of sender
    int dest;           // Rank of receiver
    int tag = 50;       // Tag for messages
    char message[MSG_LEN];  // Storage for the message
    MPI_Status status;  // Return status for receive

    // Launch MPI processes on each node
    MPI_Init(&argc, &argv);
    // Request a rank (also: thread id, tid) from the MPI master process, whose
    // rank == 0
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    // Get the number of processes launched by MPI.
    MPI_Comm_size(MPI_COMM_WORLD, &n_procs);

    // Hand out a number and let each process change that number.
    int number = 2;
    MPI_Bcast(
        &number,    // message
        1,          // how many `message` to send to each process?
        MPI_INT,    // data type of `message`
        0,          // rank of process that sends `message` (typically: root)
        MPI_COMM_WORLD // communicator
    );
    number *= my_rank;

    // Get the altered number from each process.
    int total;
    MPI_Reduce(
        &number, // operand (what's being reduced)
        &total,  // result (result of reduction)
        1,       // count: num of `datatype` being fetched from each process
        MPI_INT, // datatype
        MPI_SUM, // operation
        0,       // rank of process that gets result (typically: root)
        MPI_COMM_WORLD  // communicator
    );
    if(0 == my_rank) {
        printf("total: %d\n", total);
    }

    MPI_Finalize();
} // main
