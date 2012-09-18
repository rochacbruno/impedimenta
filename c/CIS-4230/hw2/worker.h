#ifndef WORKER_H
#define WORKER_H

#include <pthread.h>
#include <stdbool.h>

struct work_unit {
    void * (* function)(); // Execute this function
    void * arg;            // with this arg
    void * result;         // and place the return value here.
};
struct control_panel { // Treat contents as private! Only modify via functions.
    pthread_mutex_t lock;
    pthread_cond_t  alarm_clock;
    bool            should_die;
    bool            new_work;
    bool            work_done;
    struct work_unit work;
};

void   control_panel_init(struct control_panel * panel);
void   control_panel_set_work(
           struct control_panel * panel,
           struct work_unit work
       );
void * worker(void * arg); // arg: pointer to a ``struct control_panel``
void   worker_work(struct control_panel * panel);
bool   worker_is_done(struct control_panel * panel);
void   worker_die(struct control_panel * panel);

#endif // #ifndef WORKER_H
