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
        // Sleep until alarm_clock rings. Ensure wakeup is not spurious. Check
        // new_work before checking should_die. Both flags may be true at the
        // same time.
        pthread_mutex_lock(&panel->lock);
        while(false == panel->new_work && false == panel->should_die)
            pthread_cond_wait(&panel->alarm_clock, &panel->lock);
        if(true == panel->new_work) {
            panel->new_work = false;
            pthread_mutex_unlock(&panel->lock); // unlock before working!
            //panel->work_result = panel->work(panel->work.arg); // TODO
            panel->work.function(panel->work.arg);
            // Notify thread pool that worker is idle *after* setting work_done
            // to true. Ensures thread pool can figure out which worker is idle.
            pthread_mutex_lock(&panel->lock);
            panel->work_done = true;
            sem_post(panel->idle_workers);
        }
        if(true == panel->should_die) {
            // Unlock panel before dying. (ensures caller can still access it)
            pthread_mutex_unlock(&panel->lock);
            return NULL;
        }
        pthread_mutex_unlock(&panel->lock);
    }
}

void worker_die(struct worker_control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->should_die = true;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

bool worker_is_idle(struct worker_control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    bool is_done = panel->work_done;
    pthread_mutex_unlock(&panel->lock);

    return is_done;
}
