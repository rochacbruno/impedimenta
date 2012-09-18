#include "worker.h"
#include <stdio.h>

// Populate control panel with sane defaults. NOT thread-safe
void control_panel_init(struct control_panel * panel) {
    pthread_cond_init(&panel->alarm_clock, NULL);
    pthread_mutex_init(&panel->lock, NULL);
    panel->should_die = false;
    panel->new_work = false;
    panel->work_done = true;

    return;
}

// Input work directions to control panel. Do not wake worker; do that with
// worker_work.
void control_panel_set_work(
    struct control_panel * panel,
    struct work_unit work
) {
    pthread_mutex_lock(&panel->lock);
    panel->work = work;
    pthread_mutex_unlock(&panel->lock);
}

//================//

void * worker(void * arg) { // arg: struct control_panel * panel
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

// Thread-safe. Tell worker to wake up and execute work unit.
void worker_work(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->new_work = true;
    panel->work_done = false;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

// Thread-safe. Tell worker to wake up and die.
void worker_die(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->should_die = true;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

// Thread-safe. Returns true if worker done with job, else false.
bool worker_is_done(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    bool is_done = panel->work_done;
    pthread_mutex_unlock(&panel->lock);

    return is_done;
}
