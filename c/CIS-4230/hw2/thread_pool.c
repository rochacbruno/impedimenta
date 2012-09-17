#include "thread_pool.h"
#include <sys/sysinfo.h>
#include <stdlib.h>

void thread_pool_init(struct thread_pool * pool) {
    const int NUM_THREADS = get_nprocs();

    pool->num_threads = NUM_THREADS;
    pool->worker_IDs = malloc(NUM_THREADS * sizeof(pthread_t));
    pool->panels = malloc(NUM_THREADS * sizeof(struct control_panel));
    for(int i = 0; i < NUM_THREADS; i++) {
        control_panel_init(&pool->panels[i]);
        // Create worker. Give it an ID, a sleep/work/die routine, and a control
        // panel to control that routine.
        pthread_create(
            &pool->worker_IDs[i],
            NULL,
            worker,          // function
            &pool->panels[i] // argument
        );
    }

    return;
}

void thread_pool_work(struct thread_pool * pool, struct work_unit * work) {
    return;
}

void thread_pool_die(struct thread_pool * pool) {
    for(int i = 0; i < pool->num_threads; i++) {
        // Workers will never return unless told to die.
        worker_die(&pool->panels[i]);
        pthread_join(pool->worker_IDs[i], NULL);
    }
    free(pool->worker_IDs);
    free(pool->panels);

    return;
}
