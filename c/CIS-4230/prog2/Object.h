/*! \file    Object.h
    \brief   Definition of a object data arrays.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

*/

#ifndef OBJECT_H
#define OBJECT_H

#include <math.h>

#include "main.h" // for constants and MPI libs
#include "Octree.h"
#include "Vector3.h"

// These constants can change the behavior of all programs that share this header.
#define OBJECT_COUNT     500
#define AU               1.49597870700E+11  // Meters per astronomical unit.
#define AVERAGE_VELOCITY 2.9785E+4   // Meters per second (used during random initialization).
#define G                6.673E-11   // Gravitational constant.
#define TIME_STEP        3.6E+03     // Seconds in a time step (one hour).
// The AVERAGE_VELOCITY above is the magnitude of the velocity of Earth in its orbit.

//! Structure that represents the position and velocity of a particular object.
/*!
 * This structure encapsulates the dynamic properties of an object.
 */
typedef struct {
    Vector3 position;
    Vector3 velocity;
} ObjectDynamics;

//! Structure that represents an individual object.
/*!
 * This class defines the object's unchanging mass.
 */
typedef struct {
    double mass;
} Object;

// Three parallel arrays are used to hold object information. These arrays are indexed by an
// integer object ID. The current_dynamics array contains the current position and velocity of
// all the objects. The next_dynamics array contains the estimated position and velocity of all
// the objects after the current time step.
//
extern Object         * object_array;
extern ObjectDynamics * current_dynamics;
extern ObjectDynamics * next_dynamics;

//! Compute the next dynamics from the current dynamics.
/*!
 * This function takes one step of simulated time. my_rank is the rank of the
 * current MPI process.
 */
void time_step(
    const int n_procs,
    const int my_rank,
    Timer * const stopwatch1,
    Timer * const stopwatch2
);


//! Print the current dynamics.
void dump_dynamics();

#endif
