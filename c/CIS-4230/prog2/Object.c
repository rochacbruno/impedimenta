/*! \file    Object.c
    \brief   Implementation of object data arrays.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>
*/

#include "Object.h"

#define ROOT 0 // rank of root process

Object         * object_array;
ObjectDynamics * current_dynamics;
ObjectDynamics * next_dynamics;

Box overall_region = {
    .x_interval = { -100.0 * AU, 100.0 * AU },
    .y_interval = { -100.0 * AU, 100.0 * AU },
    .z_interval = { -100.0 * AU, 100.0 * AU }
};

void time_step(
    int n_procs,
    int my_rank,
    Timer * stopwatch1,
    Timer * stopwatch2
) {
    Octree spacial_tree;

    // TODO: Broadcast current_dynamics from ROOT to all other processes.

    Octree_init(&spacial_tree, &overall_region);
    Timer_start(stopwatch1);
    for(int i = 0; i < OBJECT_COUNT; ++i) {
        Octree_insert(
            &spacial_tree,
            current_dynamics[i].position,
            object_array[i].mass
        );
    }
    Timer_stop(stopwatch1);
    Octree_refresh_interior(&spacial_tree);

    // TODO: Make each process calculate only some of the next_dynamics. That
    // is, make each process run only part of the for loop below.

    // For each object...
    Timer_start(stopwatch2);
    for(int object_i = 0; object_i < OBJECT_COUNT; ++object_i) {
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

    // TODO: gather next_dynamics from each process.

    // Swap the dynamics arrays.
    ObjectDynamics *temp = current_dynamics;
    current_dynamics     = next_dynamics;
    next_dynamics        = temp;
}

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

// Given a Vector3 struct, create a derived MPI datatype that can be broadcast.
void _create_derived_vector3(
    Vector3 * input_data,
    MPI_Datatype * message_type_ptr
) {
    // A resultant MPI_Datatype is composed of blocks. Each block can hold an
    // arbitrary number of variables, but all variables in a block must be of
    // the same type. In this function, we'll create three separate blocks, not
    // because it's necessarily the "right" way to create a derived datatype,
    // but because the example in the MPI User's Guide does it this way.

    // Specify datatypes of blocks.
    MPI_Datatype typelist[3];
    typelist[0] = typelist[1] = typelist[2] = MPI_FLOAT;

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
