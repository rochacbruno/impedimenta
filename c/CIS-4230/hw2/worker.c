#include "worker.h"

void worker_cockpit_init(struct worker_cockpit * cockpit) {
    pthread_cond_init(&cockpit->alarm_clock, NULL);
    pthread_mutex_init(&cockpit->lock, NULL);
    cockpit->do_task = false;
    cockpit->should_die = false;

    return;
}

// struct worker_cockpit * cockpit
void * worker(void * arg) {
    struct worker_cockpit * cockpit = (struct worker_cockpit *)arg;
    while(1) {
        // Sleep until alarm_clock rings. Notice how do_task immediately resets
        // to false. Think of it as a button that resets after being pressed.
        pthread_mutex_lock(&cockpit->lock);
        while(false == cockpit->do_task)
            pthread_cond_wait(&cockpit->alarm_clock, &cockpit->lock);
        cockpit->do_task = false;
        if(true == cockpit->should_die) { // Die?
            pthread_mutex_unlock(&cockpit->lock);
            return NULL;
        }
        pthread_mutex_unlock(&cockpit->lock);

        // Have been woken up and was not told to die. Default to doing work.
        cockpit->task_result = cockpit->task(cockpit->task_arg);
    }
}

// Thread-safe. Tell worker to wake up.
void worker_wake_up(struct worker_cockpit * cockpit) {
    pthread_mutex_lock(&cockpit->lock);
    cockpit->do_task = true;
    pthread_mutex_unlock(&cockpit->lock);

    pthread_cond_signal(&cockpit->alarm_clock);
}

// Thread-safe. Tell worker to die.
void worker_kill(struct worker_cockpit * cockpit) {
    pthread_mutex_lock(&cockpit->lock);
    cockpit->should_die = true;
    pthread_mutex_unlock(&cockpit->lock);

    worker_wake_up(cockpit);
}

// Thread-safe. Tell worker what to do.
// TODO: block until worker is sleeping
void worker_give_task(
    struct worker_cockpit * cockpit,
    void * task,
    void * task_arg,
    void * task_result
) {
    pthread_mutex_lock(&cockpit->lock);
    cockpit->task = task;
    cockpit->task_arg = task_arg;
    cockpit->task_result = task_result;
    pthread_mutex_unlock(&cockpit->lock);
}
