#ifndef WORKER_H
#define WORKER_H

#include <pthread.h>
#include <stdbool.h>

struct work_unit {
    void * (* function)(); // Execute this function
    void * arg;            // with these args
    void * result;         // and place the return value here.
};
struct control_panel { // Treat contents as private! Only modify via functions.
    pthread_mutex_t lock;
    pthread_cond_t  alarm_clock; // Wakes worker if worker sleeping
    bool            should_die; // True if worker should die
    bool            work_ready;
    bool            work_done;
    struct work_unit work;
};

void   control_panel_init(struct control_panel * panel);
void   control_panel_work(struct control_panel * panel, struct work_unit work);
void * worker(void * arg); // arg: struct control_panel * panel
void   worker_work(struct control_panel * panel);
bool   worker_is_done();
void   worker_die(struct control_panel * panel);

#endif // #ifndef WORKER_H
