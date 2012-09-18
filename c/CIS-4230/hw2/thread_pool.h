#include "worker.h"
#include <pthread.h>

struct thread_pool {
    pthread_t * worker_IDs; // array
    struct control_panel * panels; // array
    int num_threads;
    // semaphore: number of free threads
    // signal: thread done
    // lock: for semaphore and signal
};

void thread_pool_init(struct thread_pool * pool);
void thread_pool_give_work(struct thread_pool * pool, struct work_unit work);
void thread_pool_die(struct thread_pool * pool);
