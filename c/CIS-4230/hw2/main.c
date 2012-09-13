#include "worker.h"
#include <stdio.h>
#include <sys/sysinfo.h>

void * print_hello(void * arg) {
    printf("hello!\n");
    return NULL;
}

int main() {
    const int NUM_THREADS = get_nprocs();
    struct control_panel panels[NUM_THREADS];
    pthread_t worker_IDs[NUM_THREADS];

    printf("number of threads: %d\n", NUM_THREADS);

    for(int i = 0; i < NUM_THREADS; i++) {
        control_panel_init(&panels[i]);         // initialize control panels
        struct work_unit task = {               // create jobs
            .function = print_hello,
            .arg = NULL,
            .result = NULL
        };
        control_panel_set_task(&panels[i], task); // input job into contol panel
        pthread_create(                         // create workers, give them CPs
            &worker_IDs[i],
            NULL,
            worker, // function to execute
            &panels[i] // argument to function
        );
        worker_wake_up(&panels[i]);             // wake workers
    }
    for(int i = 0; i < NUM_THREADS; i++) {
        worker_kill(&panels[i]);
        pthread_join(worker_IDs[i], NULL);
    }

    return 0;
}
