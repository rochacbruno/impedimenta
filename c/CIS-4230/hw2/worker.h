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
    bool            do_task; // Set to true to make worker take action
    struct work_unit task;
};

void   control_panel_init(struct control_panel * panel);
void   control_panel_set_task(struct control_panel * panel, struct work_unit task);
void * worker(void * arg); // arg: struct control_panel * panel
void   worker_wake_up(struct control_panel * panel);
void   worker_kill(struct control_panel * panel);

#endif // #ifndef WORKER_H
