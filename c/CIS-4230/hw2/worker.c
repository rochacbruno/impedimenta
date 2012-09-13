#include "worker.h"
#include <stdio.h>

// NOT thread-safe
void control_panel_init(struct control_panel * panel) {
    pthread_cond_init(&panel->alarm_clock, NULL);
    pthread_mutex_init(&panel->lock, NULL);
    panel->do_task = false;
    panel->should_die = false;

    return;
}

void * worker(void * arg) { // arg: struct control_panel * panel
    struct control_panel * panel = (struct control_panel *)arg;
    while(1) {
        // Sleep until alarm_clock rings. Notice how do_task immediately resets
        // to false. Think of it as a button that resets after being pressed.
        pthread_mutex_lock(&panel->lock);
        while(false == panel->do_task)
            pthread_cond_wait(&panel->alarm_clock, &panel->lock);
        panel->do_task = false;
        if(true == panel->should_die) { // Die?
            pthread_mutex_unlock(&panel->lock);
            return NULL;
        }
        pthread_mutex_unlock(&panel->lock);

        // Have been woken up and was not told to die. Default to doing work.
        //panel->task_result = panel->task(panel->task_arg);
        panel->task.function();
    }
}

// Thread-safe. Tell worker to wake up.
void worker_wake_up(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->do_task = true;
    pthread_mutex_unlock(&panel->lock);
    pthread_cond_signal(&panel->alarm_clock);
}

// Thread-safe. Tell worker to die.
void worker_kill(struct control_panel * panel) {
    pthread_mutex_lock(&panel->lock);
    panel->should_die = true;
    pthread_mutex_unlock(&panel->lock);
    worker_wake_up(panel);
}

// Input directions for job to control panel.
// TODO: block until worker is sleeping
void control_panel_set_task(
    struct control_panel * panel,
    struct work_unit task
) {
    pthread_mutex_lock(&panel->lock);
    panel->task = task;
    pthread_mutex_unlock(&panel->lock);
}
