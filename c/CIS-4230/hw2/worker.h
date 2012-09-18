#ifndef WORKER_H
#define WORKER_H

#include <pthread.h>
#include <stdbool.h>
#include <semaphore.h>

struct worker_work {
    void * (* function)(); // Execute this function
    void * arg;            // with this arg
    void * result;         // and place the return value here.
};
struct worker_control_panel { // Treat contents as private! Only modify via functions.
    pthread_mutex_t lock;
    pthread_cond_t  alarm_clock;
    bool            should_die;
    bool            new_work;
    bool            work_done; // TODO: move to worker_work?
    struct worker_work work;
    sem_t * idle_workers; // incremented after worker completes work
};

/* ========================================================================== *\
Populates ``panel`` with ``idle_workers`` and other sane decault settings.
This should be called on the panel before using the panel for *anyhing* else.
\* ========================================================================== */
void worker_control_panel_init(
    struct worker_control_panel * panel,
    sem_t * idle_workers
);

/* ========================================================================== *\
Function which can be run as a thread and managed using a
``worker_control_panel``. Why the weird function signature? Well, the supporting
thread library used is pthread.h, and pthread_t() requires this signature due to
the limitations of the C language (C doesn't have generics).
\* ========================================================================== */
void * worker(void * arg);

/* ========================================================================== *\
Inputs ``work`` into the ``panel``, fiddles other flags as needed, and wakes the
worker. Thread-safe. Job is done when ``worker_is_done()`` returns true.
\* ========================================================================== */
void worker_give_work(
    struct worker_control_panel * panel,
    struct worker_work work
);

/* ========================================================================== *\
Returns true if worker done with work. Else, returns false. Thread-safe.
\* ========================================================================== */
bool worker_is_done(struct worker_control_panel * panel);

/* ========================================================================== *\
Tells the worker using ``panel`` to wake up and die. Thread-safe.
\* ========================================================================== */
void worker_die(struct worker_control_panel * panel);

#endif // #ifndef WORKER_H
