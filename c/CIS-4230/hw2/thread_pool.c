#include "thread_pool.h"
#include <sys/sysinfo.h>
#include <stdlib.h>

void thread_pool_init(struct thread_pool * pool) {
    const int num_threads = get_nprocs();

    pool->num_threads = num_threads;
    pool->worker_IDs = malloc(num_threads * sizeof(pthread_t));
    pool->panels = malloc(num_threads * sizeof(struct control_panel));
    for(int i = 0; i < num_threads; i++) {
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

void thread_pool_give_work(struct thread_pool * pool, struct work_unit work) {
    // TODO: lock
    // TODO: while semaphore 0, wait (unlocked while waiting)
    for(int i = 0; i < pool->num_threads; i++) {
        if(worker_is_done(&pool->panels[i])) {
            worker_give_work(&pool->panels[i], work); // TODO: merge these
            break;
        }
     }
    // TODO: give job and decrement semaphore
    // TODO: unlock

    return;
}

void thread_pool_die(struct thread_pool * pool) {
    for(int i = 0; i < pool->num_threads; i++)
        worker_die(&pool->panels[i]);
    for(int i = 0; i < pool->num_threads; i++)
        pthread_join(pool->worker_IDs[i], NULL);
    free(pool->worker_IDs);
    free(pool->panels);

    return;
}
