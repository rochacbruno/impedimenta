#include "worker.h"
#include <stdio.h>
#include <sys/sysinfo.h>

#define NUM_JOBS 50

void * print_hello(void * arg) {
    printf("hello!\n");
    return NULL;
}

int main() {
    const int NUM_THREADS = get_nprocs();
    pthread_t worker_IDs[NUM_THREADS];
    struct control_panel panels[NUM_THREADS];
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

    for(int i = 0; i < NUM_JOBS; i++) {
        printf("Creating task %d.\n", i);
        struct work_unit task = {
            .function = print_hello,
            .arg = NULL,
            .result = NULL
        };
        printf("Waiting for worker %d to complete previous job.\n", i % NUM_THREADS);
        while(!worker_is_done(&panels[i % NUM_THREADS]));

        printf("Giving worker %d new job.\n", i % NUM_THREADS);
        control_panel_work(&panels[i % NUM_THREADS], task);
        worker_work(&panels[i % NUM_THREADS]);
    }
    for(int i = 0; i < NUM_THREADS; i++) {
        printf("Instructing worker %d to die.\n", i);
        worker_die(&panels[i % NUM_THREADS]);
        printf("Joining worker %d.\n", i);
        pthread_join(worker_IDs[i % NUM_THREADS], NULL);
    }

    return 0;
}
