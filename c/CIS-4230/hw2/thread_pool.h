#ifndef THREAD_POOL_H
#define THREAD_POOL_H

#include "worker.h"
#include <pthread.h>
#include <semaphore.h>
#include <sys/sysinfo.h>
#include <stdlib.h>

/* ========================================================================== *\
This struct stores info about the state of a thread pool.

After creating a ``struct thread_pool``, you should treat the contents of that
thread_pool as private. Instead, manipulate the thread_pool by passing it to
various functions in this header file.
\* ========================================================================== */
struct thread_pool {
    int   num_workers;
    sem_t idle_workers;
    pthread_t * worker_IDs; // malloc'd array
    struct worker_control_panel * panels; // malloc'd array
};

/* ========================================================================== *\
Populates ``pool`` with sane default settings. Creates threads and allocates
resources as needed.
\* ========================================================================== */
void thread_pool_init(struct thread_pool * pool);

/* ========================================================================== *\
Waits for a thread in ``pool`` to become free, then gives it ``work``. Once a
thread has been given work, that work is guaranteed to complete, even if
``thread_pool_die`` is called.
\* ========================================================================== */
void thread_pool_give_work(
    struct thread_pool * pool,
    struct worker_work * work
);

/* ========================================================================== *\
Tells all threads to die. Waits for threads to die, then deallocates resources.
\* ========================================================================== */
void thread_pool_die(struct thread_pool * pool);

#endif // #ifndef THREAD_POOL_H
