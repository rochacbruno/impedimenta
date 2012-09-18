#include "worker.h"
#include <stdio.h>

/* ========================================================================== *\
Populates ``panel`` with sane default settings. This should be called on the
panel before using the panel it for *anyhing* else.
\* ========================================================================== */
void control_panel_init(struct control_panel * panel) {
    pthread_cond_init(&panel->alarm_clock, NULL);
    pthread_mutex_init(&panel->lock, NULL);
    panel->should_die = false;
    panel->new_work = false;
    panel->work_done = true;

    return;
}

/* ========================================================================== *\
Inputs ``work`` into the ``panel``, fiddles other flags as needed, and wakes the
worker. Thread-safe. Job is done when ``worker_is_done()`` returns true.
\* ========================================================================== */
void worker_give_work(
    struct control_panel * panel,
    struct work_unit work
) {
    pthread_mutex_lock(&panel->lock);
    panel->work = work;
    panel->new_work = true;
    panel->work_done = false;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

/* ========================================================================== *\
Function which can be run as a thread and managed using a ``control_panel``.

Why the weird function signature? Well, the supporting thread library used is
pthread.h, and pthread_t() requires this signature due to the limitations of the
C language (C doesn't have generics).
\* ========================================================================== */
void * worker(void * arg) {
    struct control_panel * panel = (struct control_panel *)arg;
    while(1) {
        // Sleep until alarm_clock rings. Then, either die or do work. If dying,
        // first unlock control panel (ensures caller can still use it).
        pthread_mutex_lock(&panel->lock);
        while(false == panel->new_work && false == panel->should_die)
            pthread_cond_wait(&panel->alarm_clock, &panel->lock);
        if(true == panel->should_die) {
            pthread_mutex_unlock(&panel->lock);
            return NULL;
        }
        panel->new_work = false;
        pthread_mutex_unlock(&panel->lock);

        //panel->work_result = panel->work(panel->work.arg); // TODO
        panel->work.function(panel->work.arg);
        panel->work_done = true;
    }
}

/* ========================================================================== *\
Tells the worker using ``panel`` to wake up and die. Thread-safe.
\* ========================================================================== */
void worker_die(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->should_die = true;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

/* ========================================================================== *\
Returns true if worker done with work. Else, returns false. Thread-safe.
\* ========================================================================== */
bool worker_is_done(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    bool is_done = panel->work_done;
    pthread_mutex_unlock(&panel->lock);

    return is_done;
}
