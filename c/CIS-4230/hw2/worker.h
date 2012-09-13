#ifndef WORKER_H
#define WORKER_H

#include <pthread.h>
#include <stdbool.h>

struct worker_cockpit {
    pthread_mutex_t lock;
    bool working; // True if working, false if sleeping
    bool should_die; // True if worker should die
    pthread_cond_t alarm_clock; // Wakes worker if worker sleeping
};
void worker_cockpit_init(struct worker_cockpit * cockpit);
void worker(struct worker_cockpit * cockpit);
void kill_worker(struct worker_cockpit * cockpit);

#endif // #ifndef WORKER_H
