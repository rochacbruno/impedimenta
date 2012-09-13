#ifndef WORKER_H
#define WORKER_H

#include <pthread.h>
#include <stdbool.h>

/*
struct work_unit {
    void * task; // function to execute...
    void * task_arg; // ... with these args...
    void * task_result; // ... placing result here.
};
*/
struct worker_cockpit { // Treat contents as private! Only modify via functions.
    pthread_mutex_t lock;
    pthread_cond_t  alarm_clock; // Wakes worker if worker sleeping
    bool should_die; // True if worker should die
    bool do_task; // Set to true to make worker take action
    void * task; // function to execute...
    void * task_arg; // ... with these args...
    void * task_result; // ... placing result here.
};

void   worker_cockpit_init(struct worker_cockpit * cockpit);
void * worker(void * arg); // arg is: struct worker_cockpit * cockpit
void worker_give_task(
    struct worker_cockpit * cockpit,
    void * task,
    void * task_arg,
    void * task_result
);
void   worker_wake_up(struct worker_cockpit * cockpit);
void   worker_kill(struct worker_cockpit * cockpit);

#endif // #ifndef WORKER_H
