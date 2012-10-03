/*! \file    Vector3.h
    \brief   Handling of three dimensional vectors.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

*/

#ifndef VECTOR3_H
#define VECTOR3_H

typedef double floating_t;

//! Structure that represents a three dimensional vector.
/*!
 *  This structure simplifies vector computations by encapsulating the handling of the vector's
 *  components.
 */
typedef struct {
	floating_t x;
	floating_t y;
	floating_t z;
} Vector3;

Vector3 v3_add( Vector3 a, Vector3 b );
Vector3 v3_subtract( Vector3 a, Vector3 b );
Vector3 v3_multiply( floating_t scale_factor, Vector3 a );
Vector3 v3_divide( Vector3 a, floating_t scale_factor );

floating_t magnitude_squared( Vector3 a );

#endif
