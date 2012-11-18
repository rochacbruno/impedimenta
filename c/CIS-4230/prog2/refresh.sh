#!/usr/bin/env bash

make -f Makefile.gcc clean
make -f Makefile.gcc
mpirun -np 3 MPI
