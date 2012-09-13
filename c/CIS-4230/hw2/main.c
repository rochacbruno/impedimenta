#include "worker.h"
#include <stdio.h>
#include <sys/sysinfo.h>

void * print_hello(void * arg) {
    printf("hello!\n");
    return NULL;
}

int main() {
    const int NUM_THREADS = get_nprocs();
    struct worker_cockpit cockpits[NUM_THREADS];
    pthread_t worker_IDs[NUM_THREADS];

    printf("number of threads: %d\n", NUM_THREADS);

    for(int i = 0; i < NUM_THREADS; i++) {
        worker_cockpit_init(&cockpits[i]);
        pthread_create(
            &worker_IDs[i],
            NULL,
            worker,
            &cockpits[i]
        );
    }
    for(int i = 0; i < NUM_THREADS; i++) {
        printf("giving worker %d a task\n", i);
        worker_give_task(
            &cockpits[i],
            print_hello,
            NULL,
            NULL
        );
        worker_wake_up(&cockpits[i % NUM_THREADS]);
    }
    for(int i = 0; i < NUM_THREADS; i++)
        worker_kill(&cockpits[i]);
    for(int i = 0; i < NUM_THREADS; i++)
        pthread_join(worker_IDs[i], NULL);

    return 0;
}
