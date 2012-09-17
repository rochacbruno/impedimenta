#include "worker.h"
#include <pthread.h>

struct thread_pool {
    pthread_t * worker_IDs; // array
    struct control_panel * panels; // array
    int num_threads;
};

void thread_pool_init(struct thread_pool * pool);
void thread_pool_work(struct thread_pool * pool, struct work_unit * work);
void thread_pool_die(struct thread_pool * pool);
