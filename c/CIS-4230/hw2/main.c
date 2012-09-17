#include "worker.h"
#include "thread_pool.h"
#include <stdio.h>
#include <sys/sysinfo.h>
#include <stdlib.h>

void * print_hello(void * arg) {
    int num = *(int *)arg;

    printf("hello from thread: %d\n", num);

    return NULL;
}

int main() {
    const int NUM_JOBS = 500; // arbitrary
    struct work_unit tasks[NUM_JOBS];
    struct thread_pool pool;

    thread_pool_init(&pool);
/*
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
    for(int i = 0; i < NUM_JOBS; i++)
        free(tasks[i].arg);
*/

    thread_pool_die(&pool);

    return 0;
}
