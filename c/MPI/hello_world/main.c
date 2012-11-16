// To compile and run:
// mpicc main.c
// mpirun -np 4 ./a.out

#include <stdio.h>
#include "mpi.h"

#define MSG_LEN 100

main(int argc, char ** argv) {
    int my_rank;        // Rank of process
    int num_procs;      // Number of processes
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
    MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

    // All processes > 0 send messages to processes 0.
    if(0 != my_rank) {
        sprintf(message, "Greetings from process %d!", my_rank);
        dest = 0;
        MPI_Send(
            message,            // message being sent
            strlen(message) + 1, // how much to send? +1 to include '\0'
            MPI_CHAR,           // data type of message
            dest,               // rank of dest (no MPI_ANY_DEST exists)
            tag,                // tag          (cannot use MPI_ANY_TAG)
            MPI_COMM_WORLD      // communicator (message space partition)
        );
    } else {
        for(source = 1; source < num_procs; source++) {
            MPI_Recv(
                message,        // where to put received data
                MSG_LEN,        // length of message
                MPI_CHAR,       // data type of message
                source,         // rank of source (also: MPI_ANY_SOURCE)
                tag,            // tag            (also: MPI_ANY_TAG)
                MPI_COMM_WORLD, // communicator (message space partition)
                &status // rank and tag of msg rcvd (useful if using MPI_ANY_*)
            );
            printf("%s\n", message);
        }
    }

    MPI_Finalize();
} // main
