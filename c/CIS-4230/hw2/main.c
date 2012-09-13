#include "worker.h"
#include <stdio.h>
#include <sys/sysinfo.h>

#define NUM_ITERATIONS 1000

void main() {
    const int NUM_THREADS = get_nprocs();
    struct worker_cockpit cockpits[NUM_THREADS];
    pthread_t worker_IDs[NUM_THREADS];
    time_t start_time, end_time;

    printf("number of threads: %d\n", NUM_THREADS);
    start_time = time(NULL);
    printf("start time: %d\n", start_time);

    for(int i = 0; i < NUM_THREADS; i++) {
        worker_cockpit_init(&cockpits[i]);
        pthread_create(
            &worker_IDs[i],
            NULL,
            worker,
            &cockpits[i]
        );
    }
    for(int i = 0; i < NUM_ITERATIONS; i++)
        worker_wake_up(&cockpits[i % NUM_THREADS]);
    for(int i = 0; i < NUM_THREADS; i++)
        worker_kill(&cockpits[i]);
    for(int i = 0; i < NUM_THREADS; i++)
        pthread_join(worker_IDs[i], NULL);

    end_time = time(NULL);
    printf("end time: %d\n", end_time);
    printf("time elapsed: %d\n", end_time - start_time);

    return;
}
