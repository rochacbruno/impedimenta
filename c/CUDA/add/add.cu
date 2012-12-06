/*-==========================================================================-*\

Program Description
===================

This program demonstrates basic usage of the CUDA toolkit. `a` and `b` are
defined on the host, and these two values are passed to the device. The device
sums the values, and the result is copied back to the host.

Notes
=====

The hierarchy for structuring CUDA threads is: grid -> block -> thread. A kernel
has three predefined data structures available to it: `blockIDx`, `blockDim`,
and `threadIdx`.

`blockIDx` contains the index of the current block within it's grid. A grid is
two-dimensional, so available struct members are:

* blockIDx.x
* blockIDx.y

`blockDim` contains number of threads in the current block. A block is
three-dimensional, so available struct members are:

* blockDim.x
* blockDim.y
* blockDim.z

`threadIdx` contains the index of the current thread within it's block. Struct
members are:

* threadIDx.x
* threadIDx.y
* threadIDx.z

\*-==========================================================================-*/

#include <stdio.h>
#include <stdlib.h>

// c = a + b
__global__ void add(
    const int a, // input
    const int b, // input
    int * const c // output
) {
    *c = a + b;
}

// Calls `add` and prints the results of that call.
int main(void) {
    // Define and allocate host variables.
    const int a = 2;
    const int b = 7;
    int c = 1234; // The printf() statement at the end should not output 1234.

    // Define and allocate device variables.
    int * dev_c;
    cudaMalloc(&dev_c, sizeof(int));

    // Perform business logic.
    // blocks per grid, threads per block
    add<<<1, 1>>>(a, b, dev_c);
    // dest, src, amount, operation
    cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
    printf("%d + %d = %d\n", a, b, c);

    // Free allocated memory.
    cudaFree(dev_c);

    return EXIT_SUCCESS;
}
