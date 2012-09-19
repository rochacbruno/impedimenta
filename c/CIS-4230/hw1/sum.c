/*! \file    sum.c
    \brief   Program for CIS-4230, Homework #1.
    \author  Jeremy Audet <ichimonji10@gmail.com>

    This program adds all the integers in a large array.
*/

#include <stdlib.h>
#include <stdio.h>
#include <sys/sysinfo.h>
#include <pthread.h>

struct work_unit {
    int * inputs;   // an array to iterate over and sum
    int size;       // array has ``size`` elements
    int start_pos;  // thread starts counting at inputs[offset]...
    int jump_size;  // ...and continues counting every jump_size'th element
    int result;     // thread places result of summation here
};

//! Returns a dynamically created array of random ints in the range 1 .. 10.
/*!
 * This function prepares an array of random values for use by the summation
 * algorithm. Each element in the array is in the range 1 to 10.
 *
 * \param total_size The number of array elements desired. Should be positive.
 * \return A pointer to a dynamically allocated array. The caller must free the
 *     array.
 */
int * create_array(int total_size)
{
    int * array = (int *)malloc(total_size * sizeof(int));
    
    for(int i = 0; i < total_size; i++) {
        array[i] = (rand() % 10) + 1;
    }
    return array;
}

//! Add all the integers in the array.
/*!
 * \param args A pointer to a struct work_unit.
 */
void * compute_sum_parallel(void * args) {
    struct work_unit * payload = (struct work_unit *)args;

    payload->result = 0; // i.e. (*payload).result = 0;
    for(int i = payload->start_pos; i < payload->size; i += payload->jump_size)
        payload->result += payload->inputs[i];

    return NULL;
}

int main()
{
    const int   SIZE  = 100000000;
    const int   NUM_THREADS = get_nprocs();
    int *       data = create_array(SIZE);
    int         sum = 0;
    pthread_t   thread_IDs[NUM_THREADS];
    struct work_unit work_units[NUM_THREADS];

    printf("Creating %d threads...\n", NUM_THREADS);
    for(int i = 0; i < NUM_THREADS; i++) {
        work_units[i].inputs    = data;
        work_units[i].size      = SIZE;
        work_units[i].start_pos = i;
        work_units[i].jump_size = NUM_THREADS;
        pthread_create(
            &thread_IDs[i],
            NULL,
            compute_sum_parallel,
            &work_units[i]
        );
    }
    printf("Waiting for threads to finish...\n");
    for(int i = 0; i < NUM_THREADS; i++) {
        pthread_join(thread_IDs[i], NULL);
        printf("Thread %d done. Result: %d\n", i, work_units[i].result);
        sum += work_units[i].result;
    }
    free(data);
    printf("Sum total: %d\n", sum);

    return EXIT_SUCCESS;
}
