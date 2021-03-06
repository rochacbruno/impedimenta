/*!
    \file   linear_equations.h
    \brief  Interface to linear equation solver.
    \author (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
*/

#ifndef LINEAR_EQUATIONS_H
#define LINEAR_EQUATIONS_H

typedef double floating_type;

void gaussian_solve( int size, floating_type a[size][size], floating_type *b, int *error );

#endif

