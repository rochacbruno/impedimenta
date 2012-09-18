#include "worker.h"
#include <pthread.h>
#include <semaphore.h>

struct thread_pool {
    int   num_workers;
    sem_t idle_workers;
    pthread_t * worker_IDs; // array
    struct worker_control_panel * panels; // array
};

/* ========================================================================== *\
Populates ``pool`` with sane default settings. Creates threads and allocates
resources as needed.
\* ========================================================================== */
void thread_pool_init(struct thread_pool * pool);

/* ========================================================================== *\
Waits for a thread in ``pool`` to become free, then gives it ``work``.
\* ========================================================================== */
void thread_pool_give_work(struct thread_pool * pool, struct worker_work work);

/* ========================================================================== *\
Tells all threads to die. Waits for threads to die, then deallocates resources.
If any threads have pending work that has not yet been started, that work will
not be completed.
\* ========================================================================== */
void thread_pool_die(struct thread_pool * pool);
