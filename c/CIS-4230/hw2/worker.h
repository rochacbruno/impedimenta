#ifndef WORKER_H
#define WORKER_H

#include <pthread.h>
#include <stdbool.h>
#include <semaphore.h>

/* ========================================================================== *\
This struct defines what a worker thread will do when told to work.

If you are an end user of thread_pool.h, this is the *only* portion of this
header file which is relevant to you. Everything else in this header file is
used by the thread pool.
\* ========================================================================== */
struct worker_work {
    void * (* function)(); // Execute this function
    void * arg;            // with this arg
    void * result;         // and place the return value here.
};

/* ========================================================================== *\
This struct stores information about the state of a worker.

For each ``worker`` thread created, a corresponding ``worker_control_panel``
should be created. The contents of each control panel should be considered
private. To get information about the state of a worker, or to manipulate that
worker, use the functions in this header file.
\* ========================================================================== */
struct worker_control_panel {
    pthread_mutex_t lock;
    pthread_cond_t  alarm_clock;
    bool            new_work;
    bool            should_die;
    bool            work_done; // TODO: move to worker_work?
    struct worker_work work;
    sem_t * idle_workers; // incremented after worker completes work
};

/* ========================================================================== *\
Populates ``panel`` with sane default settings. Whenever a worker finishes work,
``idle_workers`` will be posted (incremented) to indicate that a worker is idle.
This should be called on a panel before using that panel for *anyhing* else.
\* ========================================================================== */
void worker_control_panel_init(
    struct worker_control_panel * panel,
    sem_t * idle_workers
);

/* ========================================================================== *\
Function which can be run as a thread and controlled with a
``worker_control_panel``.

Why the weird function signature? Well, the supporting thread library used is
pthread.h, and pthread_t() requires this signature due to the limitations of the
C language (C doesn't have generics).
\* ========================================================================== */
void * worker(void * arg);

/* ========================================================================== *\
Tells the worker holding ``panel`` to wake up and do work. Thread-safe.
\* ========================================================================== */
void worker_give_work(
    struct worker_control_panel * panel,
    struct worker_work work
);

/* ========================================================================== *\
Returns true if the worker holding ``panel`` is idle. Else, returns false.
Thread-safe.
\* ========================================================================== */
bool worker_is_idle(struct worker_control_panel * panel);

/* ========================================================================== *\
Tells the worker holding ``panel`` to wake up and die. Thread-safe.
\* ========================================================================== */
void worker_die(struct worker_control_panel * panel);

#endif // #ifndef WORKER_H
