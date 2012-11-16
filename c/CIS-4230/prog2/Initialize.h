/*! \file    Initialize.h
    \brief   Declarations initialization functions.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

*/

#ifndef INITIALIZE_H
#define INITIALIZE_H

#include "Object.h"

//! Allocate and initialize the global arrays mentioned above.
/*!
 * This function uses external configuration information to create the necessary arrays.
 * [TODO: Note the possible errors here.]
 */
void initialize_object_arrays( );

#endif // INITIALIZE_H
