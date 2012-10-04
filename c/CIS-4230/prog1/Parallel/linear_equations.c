/*!
    \file   linear_equations.c
    \brief  A gaussian elimination solver.
    \author (C) Copyright 2012 by Peter C. Chapin <PChapin@vtc.vsc.edu>
*/

#include <math.h>
#include <string.h>
#include "linear_equations.h"
#include "thread_pool/thread_pool.h"
#include "thread_pool/worker.h"

struct simplifier_args {
    int size;
    floating_type * a; // 2d array
    floating_type * b; // 1d array
    int i;             // multiply this row with a constant based off a[i]
    int row;           // the row a[row] is being adjusted here
};

void * simplifier(void * arg) {
    struct simplifier_args * args = (struct simplifier_args *)arg;
    floating_type coeff = \
        args->a[args->row * args->size + args->i] / \
        args->a[args->i * args->size + args->i];

    for(int col = 0; col < args->size; col++) {
        args->a[args->row * args->size + col] -= coeff * args->a[args->i * args->size + col];
    }
    args->b[args->row] -= coeff * args->b[args->i];

    return NULL;
}

//
// The following function does the major work of reducing the system.
//
static void elimination(
    int size,
    floating_type * a, // 2d array
    floating_type * b, // 1d array
    int * error
) {
    struct thread_pool pool;
    thread_pool_init(&pool);
    floating_type max;  // the largest value in column i is ``max``
    int max_row;        // the largest value in column i is at row ``max_row``
    int task;           // To keep track of tasks assigned to thread pool.
    floating_type temp;
    floating_type * temp_row = malloc(size * sizeof(floating_type));

    // When examining row i, you're also going to simplify row i + 1. Do not
    // examine the last row, or you will attempt to simplify a row that does not
    // exist.
    for(int i = 0; i < size - 1; i++) {
        // Consider the column containing a[i][i]. Look at all the values from
        // a[i][i] to the bottom of the matrix, and find the row with the
        // largest value.
        max = fabsf(a[i * size + i]);
        max_row = i;
        for(int row = max_row + 1; row < size; row++) {
            if(max < fabsf(a[i * size + row])) {
                max = fabsf(a[i * size + row]);
                max_row = row;
            }
        }

        // If row max_row has a larger value than row i (as per the restrictions
        // above), they should be swapped. This provides better numerical
        // stability when working on large matrices.
        if(i != max_row) {
            memcpy(temp_row, &a[i * size], size * sizeof(floating_type));
            memcpy(&a[i * size], &a[max_row * size], size * sizeof(floating_type));
            memcpy(&a[max_row * size], temp_row, size * sizeof(floating_type));
            temp = b[i];
            b[i] = b[max_row];
            b[max_row] = temp;
        }

        // For each row below row i, the value in column i should be made zero.
        // Do this by subtracting (row i) * coefficient from each subsequent
        // row. The coefficient ``k`` is different for each row.
        // Also do prep work so each worker knows what row to modify.
        struct worker_work tasks[size - i - 1];
        struct simplifier_args args[size - i - 1];
        task = 0;
        for(int row = i + 1; row < size; row++, task++) {
            worker_work_init(&tasks[task]);
            args[task].size = size;
            args[task].a = a;
            args[task].b = b;
            args[task].i = i;
            args[task].row = row;
            tasks[task].arg = (void *)&args[task];
            tasks[task].function = simplifier;
            thread_pool_give_work(&pool, &tasks[task]);
        }
        // Ensure each worker is done modifying its row before proceeding.
        for(task = 0; task < (size - i - 1); task++) {
            pthread_mutex_lock(&tasks[task].lock);
            while(false == tasks[task].work_done)
                pthread_cond_wait(&tasks[task].alarm_clock, &tasks[task].lock);
            pthread_mutex_unlock(&tasks[task].lock);
        }
    }

    thread_pool_die(&pool);
    free(temp_row);
}


//
// The following function does the back substitution step.
//
static void back_substitution(
    int size,
    floating_type * a,
    floating_type * b,
    int *error
) {
    floating_type sum;
    int           i, j;
    *error = 0;

    for(i = size - 1; i >=0; --i) {
        if(fabsf(a[i * size + i]) <= 1.0E-6) {
            *error = -2;
            return;
        }

        sum = b[i];
        for(j = i + 1; j < size; ++j) {
            sum -= a[i * size + j] * b[j];
        }
        b[i] = sum / a[i * size + i];
    }
}


//
// The following (public) function solves Ax=b using Gaussian elimination. It
// returns the solution in b. The value of *error is -1 if there is a proble
// with the parameters and -2 if the system can't be solved.
//
void gaussian_solve(
    int size,
    floating_type * a,
    floating_type * b,
    int * error
) {
    elimination(size, a, b, error);
    if(*error == 0)
        back_substitution(size, a, b, error);
}
