#include "worker.h"
#include <pthread.h>
//#include <stdbool.h>

struct thread_pool {
    pthread_t * worker_IDs;
    struct control_panel * panels;
    int num_threads;
};

void thread_pool_init(struct thread_pool * pool);
void thread_pool_work(struct work_unit * work);
void thread_pool_die();
