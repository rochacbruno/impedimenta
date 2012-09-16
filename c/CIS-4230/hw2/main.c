#include "worker.h"
#include <stdio.h>
#include <sys/sysinfo.h>
#include <stdlib.h>

void * print_hello(void * arg) {
    int num = *(int *)arg;

    printf("hello from thread: %d\n", num);

    return NULL;
}

int main() {
    const int NUM_THREADS = get_nprocs();
    const int NUM_JOBS = 500; // arbitrary
    pthread_t worker_IDs[NUM_THREADS];
    struct control_panel panels[NUM_THREADS];
    struct work_unit tasks[NUM_JOBS];

    // initialize panels
    for(int i = 0; i < NUM_THREADS ; i++) {
        printf("Prepping control panel & worker %d.\n", i);
        control_panel_init(&panels[i]);       // initialize control panel
        pthread_create(                       // Create worker. Give it ID,
            &worker_IDs[i],                   // control panel, and a default
            NULL,                             // sleep/die/work routine.
            worker, // pthread function
            &panels[i] // pthread argument
        );
    }

    // initialize tasks (with malloc!), then give job to worker
    for(int i = 0; i < NUM_JOBS; i++) {
        int * the_arg = malloc(sizeof(int));
        *the_arg = i;

        printf("Defining task %d.\n", i);
        tasks[i].function = print_hello;
        tasks[i].arg = the_arg;
        tasks[i].result = NULL;
        printf("Waiting for worker %d to complete previous job.\n", i % NUM_THREADS);
        while(!worker_is_done(&panels[i % NUM_THREADS]));

        printf("Giving worker %d new job.\n", i % NUM_THREADS);
        control_panel_work(&panels[i % NUM_THREADS], tasks[i]);
        worker_work(&panels[i % NUM_THREADS]);
    }

    // ensure all workers are done, then free malloc'd memory
    for(int i = 0; i < NUM_THREADS; i++)
        while(!worker_is_done(&panels[i]));
    for(int i = 0; i < NUM_JOBS; i++)
        free(tasks[i].arg);

    // Clean up thread pool.
    for(int i = 0; i < NUM_THREADS; i++) {
        printf("Instructing worker %d to die.\n", i);
        worker_die(&panels[i % NUM_THREADS]);
        printf("Joining worker %d.\n", i);
        pthread_join(worker_IDs[i % NUM_THREADS], NULL);
    }

    return 0;
}
