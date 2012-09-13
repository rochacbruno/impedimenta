#include "worker.h"

void worker_cockpit_init(struct worker_cockpit * cockpit) {
    pthread_cond_init(&cockpit->alarm_clock, NULL);
    pthread_mutex_init(&cockpit->lock, NULL);
    cockpit->do_work = false;
    cockpit->should_die = false;

    return;
}

// struct worker_cockpit * cockpit
void * worker(void * arg) {
    struct worker_cockpit * cockpit = (struct worker_cockpit *)arg;
    while(1) {
        // Sleep until alarm_clock rings. Notice how do_work immediately resets
        // to false. Think of it as a button that resets after being pressed.
        pthread_mutex_lock(&cockpit->lock);
        while(false == cockpit->do_work)
            pthread_cond_wait(&cockpit->alarm_clock, &cockpit->lock);
        cockpit->do_work = false;
        if(true == cockpit->should_die) { // Die?
            pthread_mutex_unlock(&cockpit->lock);
            return NULL;
        }
        pthread_mutex_unlock(&cockpit->lock);

        // Have been woken up and was not told to die. Default to doing work.
        // TODO
    }
}

// Thread-safe. Tell worker to wake up.
void worker_wake_up(struct worker_cockpit * cockpit) {
    pthread_mutex_lock(&cockpit->lock);
    cockpit->do_work = true;
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
