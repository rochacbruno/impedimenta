// To compile and run:
// mpicc main.c
// mpirun -np 4 ./a.out

#include <stdio.h>
#include "mpi.h"

#define ROOT 0
#define BUFF_SIZE 100 // in bytes

main(int argc, char ** argv) {
    int my_rank;        // Rank of process
    int num_procs;      // Number of processes
    char buffer[BUFF_SIZE]; // ints, floats, chars, etc go in/out buffer
    int position = 0;   // tracks current position while packing/unpacking
    float a;            // item to be packed+broadcasted+unpacked
    int b;              // item to be packed+broadcasted+unpacked

    // Launch MPI processes on each node
    MPI_Init(&argc, &argv);
    // Request a rank (also: thread id, tid) from the MPI master process, whose
    // rank == 0
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    // Get the number of processes launched by MPI.
    MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

    // pack buffer
    if(ROOT == my_rank) {
        a = 1.23;
        b = 4;
        printf("Each process should get a copy of a and b.\n");
        printf("a: %.4f\n", a);
        printf("b: %d\n", b);

        printf("Packing data into a buffer. Capacity = %d\n", BUFF_SIZE);
        MPI_Pack(
            &a,         // item being packed into buffer
            1,          // number of contiguous items to pack
            MPI_FLOAT,  // data type of item
            buffer,     // buffer for items
            BUFF_SIZE,  // size of buffer
            &position,  // position in buffer in which to place item
            MPI_COMM_WORLD // communicator that will be using buffer
        );
        MPI_Pack(
            &b,
            1,
            MPI_INT,
            buffer,
            BUFF_SIZE,
            &position,  // note: you don't want to place item at position 0 anymore!
            MPI_COMM_WORLD
        );
        printf("Buffer packed. Size = %d\n", position);
    }

    // broadcast buffer
    MPI_Bcast(
        buffer,
        BUFF_SIZE,
        MPI_PACKED,
        ROOT,
        MPI_COMM_WORLD
    );

    // unpack buffer
    if(ROOT != my_rank) {
        MPI_Unpack(
            buffer,
            BUFF_SIZE,
            &position,
            &a, // Unpacking from `buffer` into `a`.
            1, // Unpacking n contiguous items from `buffer`.
            MPI_FLOAT,
            MPI_COMM_WORLD
        );
        MPI_Unpack(
            buffer,
            BUFF_SIZE,
            &position,
            &b,
            1,
            MPI_INT,
            MPI_COMM_WORLD
        );
    }
    printf("Process %d: a = %.4f, b = %d\n", my_rank, a, b);

    MPI_Finalize();
} // main
