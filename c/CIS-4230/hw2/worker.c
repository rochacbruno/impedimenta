#include "worker.h"

void worker_control_panel_init(struct worker_control_panel * panel, sem_t * idle_workers) {
    pthread_cond_init(&panel->alarm_clock, NULL);
    pthread_mutex_init(&panel->lock, NULL);
    panel->should_die = false;
    panel->new_work = false;
    panel->work_done = true;
    panel->idle_workers = idle_workers;

    return;
}

void worker_give_work(
    struct worker_control_panel * panel,
    struct worker_work work
) {
    pthread_mutex_lock(&panel->lock);
    panel->work = work;
    panel->new_work = true;
    panel->work_done = false;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

void * worker(void * arg) {
    struct worker_control_panel * panel = (struct worker_control_panel *)arg;
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
        sem_post(panel->idle_workers); // notify thread pool that a worker idle
    }
}

void worker_die(struct worker_control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->should_die = true;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

bool worker_is_done(struct worker_control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    bool is_done = panel->work_done;
    pthread_mutex_unlock(&panel->lock);

    return is_done;
}
