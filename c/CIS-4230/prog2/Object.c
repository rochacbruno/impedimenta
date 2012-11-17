/*! \file    Object.c
    \brief   Implementation of object data arrays.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>
*/

#include "Object.h"

// BEGIN private function definitions ==========================================

/*-==========================================================================-*\
Given an Vector3 instance, create a corresponding MPI_Datatype. Allows one to
send Vector3 instances.
\*-==========================================================================-*/
void _describe_vector3(
    Vector3 * input_data,
    MPI_Datatype * message_type_ptr
) {
    /* The resultant MPI_Datatype is composed of several blocks. Each block can
    hold an arbitrary number of variables, but we're going to hold a single
    variable in each block here, both for simplicity's sake, and because the
    MPI User's Guide that I'm using does it this way. */

    // Specify datatypes of blocks.
    MPI_Datatype typelist[3];
    typelist[0] = typelist[1] = typelist[2] = MPI_DOUBLE;

    // How many items will go into each block?
    int block_lengths[3];
    block_lengths[0] = block_lengths[1] = block_lengths[2] = 1;

    // What's the address of each item in `input_data`? Used for discovering
    // size of each item in `input_data`.
    MPI_Aint addresses[4]; // 1 for struct itself, 1 for each struct member
    MPI_Address(input_data, &addresses[0]);
    MPI_Address(&(input_data->x), &addresses[1]);
    MPI_Address(&(input_data->y), &addresses[2]);
    MPI_Address(&(input_data->z), &addresses[3]);

    // What's the size of each item in `input_data`?
    MPI_Aint displacements[3]; // 1 for each member of `input_data`
    displacements[0] = addresses[1] - addresses[0];
    displacements[1] = addresses[2] - addresses[1];
    displacements[2] = addresses[3] - addresses[2];

    // Create a complete description of the new custom datatype.
    MPI_Type_struct(
        3, // Number of blocks being packed.
        block_lengths,
        displacements,
        typelist,
        message_type_ptr
    );
    MPI_Type_commit(message_type_ptr); // "commit" data type so it can be used.
}

/*-==========================================================================-*\
Given an ObjectDynamics instance, create a corresponding MPI_Datatype. Allows
one to send ObjectDynamics instances.
\*-==========================================================================-*/
void _describe_object_dynamics(
    ObjectDynamics * input_data,
    MPI_Datatype * message_type_ptr
) {
    /* The struct we're describing contains Vector3's, which is a non-standard
    datatype. We've got to tell MPI about those Vector3's before we can tell MPI
    about `input_data`. */
    MPI_Datatype vector3;
    _describe_vector3(&(input_data->position), &vector3);

    // Specify datatypes of blocks.
    MPI_Datatype typelist[2]; // 1 for each block
    typelist[0] = vector3;
    typelist[1] = vector3;

    // How many items will go into each block?
    int block_lengths[2]; // 1 for each block
    block_lengths[0] = block_lengths[1] = 1;

    // What's the address of each item in `input_data`? Used for discovering
    // size of each item in `input_data`.
    MPI_Aint addresses[3]; // 1 for struct itself, 1 for each struct member
    MPI_Address(input_data, &addresses[0]);
    MPI_Address(&(input_data->position), &addresses[1]);
    MPI_Address(&(input_data->velocity), &addresses[2]);

    // What's the size of each item in `input_data`?
    MPI_Aint displacements[2]; // 1 for each struct member
    displacements[0] = addresses[1] - addresses[0];
    displacements[1] = addresses[2] - addresses[1];

    // Create a complete description of the new custom datatype.
    MPI_Type_struct(
        2, // Number of blocks being packed.
        block_lengths,
        displacements,
        typelist,
        message_type_ptr
    );
    MPI_Type_commit(message_type_ptr); // "commit" data type so it can be used.
}

/*-==========================================================================-*\
Helps you split an array of arr_len into n_chunks.

For example, let's assume:
- arr_len = 200
- n_chunks = 4

The result woudld be (pseudocode):
- start_indices == [0, 50, 100, 150]
- chunk_sizes == [50, 50, 50, 50]
\*-==========================================================================-*/
void _chunk_array(
    const int arr_len, // in
    const int n_chunks, // in
    int * const start_indices, // out
    int * const chunk_sizes // out
) {
    const int chunk_size = arr_len / n_chunks; // default chunk size
    int start_i = 0;
    int end_i;

    for(int i = 0; i < n_chunks; i++) {
        end_i = start_i + chunk_size;
        if(i >= arr_len % n_chunks) {
            end_i -= 1;
        }
        start_indices[i] = start_i;
        chunk_sizes[i] = end_i - start_i;
        start_i = end_i + 1;
    }
}

// END private function definitions ============================================

Object         * object_array;
ObjectDynamics * current_dynamics;
ObjectDynamics * next_dynamics;

Box overall_region = {
    .x_interval = { -100.0 * AU, 100.0 * AU },
    .y_interval = { -100.0 * AU, 100.0 * AU },
    .z_interval = { -100.0 * AU, 100.0 * AU }
};

/*-==========================================================================-*\
time_step
\*-==========================================================================-*/
void time_step(
    const int n_procs,
    const int my_rank,
    Timer * const stopwatch1,
    Timer * const stopwatch2
) {
    // Initialize and populate the octree.
    Octree spacial_tree;
    Octree_init(&spacial_tree, &overall_region);
    Timer_start(stopwatch1);
    for(int i = 0; i < OBJECT_COUNT; ++i) {
        //if(ROOT == my_rank && DEBUG) printf("(%d) iteration %d\n", my_rank, i);
        Octree_insert(
            &spacial_tree,
            current_dynamics[i].position,
            object_array[i].mass
        );
    }
    Timer_stop(stopwatch1);
    Octree_refresh_interior(&spacial_tree);

    // Describe the ObjectDynamics type to MPI, then broadcast current_dynamics.
    if(DEBUG) printf("(%d) Calling MPI_Bcast\n", my_rank);
    MPI_Datatype object_dynamics_type;
    _describe_object_dynamics(&current_dynamics[0], &object_dynamics_type);
    MPI_Bcast(
        &(current_dynamics[0]),
        OBJECT_COUNT,
        object_dynamics_type,
        ROOT,
        MPI_COMM_WORLD
    );

    // Determine which indices of the for loop each process should do.
    if(DEBUG) printf("(%d) Running calculations\n", my_rank);
    int start_indices[n_procs];
    int chunk_sizes[n_procs];
    _chunk_array(OBJECT_COUNT, n_procs, start_indices, chunk_sizes);

    // For each object...
    Timer_start(stopwatch2);
    for(
        int object_i = start_indices[my_rank];
        object_i <= start_indices[my_rank] + chunk_sizes[my_rank];
        object_i++
    ) {
        Vector3 total_force = Octree_force(
            &spacial_tree,
            current_dynamics[object_i].position,
            object_array[object_i].mass
        );

        // Total force on object_i is now known. Compute acceleration, velocity and position.
        Vector3 acceleration   = v3_divide(total_force, object_array[object_i].mass);
        Vector3 delta_v        = v3_multiply(TIME_STEP, acceleration);
        Vector3 delta_position = v3_multiply(TIME_STEP, current_dynamics[object_i].velocity);

        next_dynamics[object_i].velocity = v3_add(
            current_dynamics[object_i].velocity,
            delta_v
        );

        next_dynamics[object_i].position = v3_add(
            current_dynamics[object_i].position,
            delta_position
        );
    }
    Timer_stop(stopwatch2);
    Octree_destroy(&spacial_tree);

    // Gather a portion of current_dynamics from each process. Concatenate into
    // buffer.
    if(ROOT != my_rank) {
        if(DEBUG) printf("(%d) MPI_Send %d elements\n", my_rank, chunk_sizes[my_rank]);
        MPI_Send(
            &(current_dynamics[start_indices[my_rank]]), // message
            chunk_sizes[my_rank],   // send count
            object_dynamics_type,   // data type of message
            ROOT,                   // rank of dest
            SEND_RECV_TAG,          // tag
            MPI_COMM_WORLD          // communicator
        );
    } else {
        MPI_Status status; // don't really care about status
        for(int rank_i = 0; rank_i < n_procs; rank_i++) {
            if(ROOT != rank_i) {
                if(DEBUG) printf("(%d) MPI_Recv %d elements from %d\n", my_rank, chunk_sizes[rank_i], rank_i);
                MPI_Recv(
                    &(current_dynamics[start_indices[rank_i]]), // recv buff
                    chunk_sizes[my_rank],   // msg len
                    object_dynamics_type,   // data type of message
                    rank_i,                 // rank of source
                    SEND_RECV_TAG,          // tag
                    MPI_COMM_WORLD,         // communicator
                    &status                 // rank and tag of msg rcvd
                );
            }
        }
    }

    // Swap current_dynamics and next_dynamics.
    if(ROOT == my_rank) {
        if(DEBUG) printf("(%d) Swapping current_dynamics and next_dynamics.\n", my_rank);
        ObjectDynamics *temp = current_dynamics;
        current_dynamics     = next_dynamics;
        next_dynamics        = temp;
    }
}

/*-==========================================================================-*\
dump_dynamics
\*-==========================================================================-*/
void dump_dynamics() {
    for(int object_i = 0; object_i < OBJECT_COUNT; ++object_i) {
        printf("%4d: x = %10.3E, y = %10.3E, z = %10.3E\n",
            object_i,
            current_dynamics[object_i].position.x,
            current_dynamics[object_i].position.y,
            current_dynamics[object_i].position.z
        );
    }
}
