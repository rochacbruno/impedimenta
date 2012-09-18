#include "thread_pool.h"
#include <sys/sysinfo.h>
#include <stdlib.h>

void thread_pool_init(struct thread_pool * pool) {
    pool->num_workers = get_nprocs();
    pool->worker_IDs = malloc(pool->num_workers * sizeof(pthread_t));
    pool->panels = malloc(pool->num_workers * sizeof(struct worker_control_panel));
    sem_init(&pool->idle_workers, 0, pool->num_workers);

    for(int i = 0; i < pool->num_workers; i++) {
        worker_control_panel_init(&pool->panels[i], &pool->idle_workers);
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

void thread_pool_give_work(struct thread_pool * pool, struct worker_work work) {
    sem_wait(&pool->idle_workers); // decrement. block if already 0
    for(int i = 0; i < pool->num_workers; i++) {
        if(worker_is_idle(&pool->panels[i])) {
            worker_give_work(&pool->panels[i], work);
            break;
        }
     }

    return;
}

void thread_pool_die(struct thread_pool * pool) {
    for(int i = 0; i < pool->num_workers; i++)
        worker_die(&pool->panels[i]);
    for(int i = 0; i < pool->num_workers; i++)
        pthread_join(pool->worker_IDs[i], NULL);
    free(pool->worker_IDs);
    free(pool->panels);

    return;
}
