#include "worker.h"

void worker_cockpit_init(struct worker_cockpit * cockpit) {
    pthread_mutex_lock(&cockpit->lock);
    cockpit->working = false;
    cockpit->should_die = false;
    pthread_mutex_unlock(&cockpit->lock);

    return;
}

void worker(struct worker_cockpit * cockpit) {
    while(1) {
        // Sleep. Wait for alarm_clock to ring.
        pthread_mutex_lock(&cockpit->lock);
        while(false == cockpit->working) {
            pthread_cond_wait(
                &cockpit->alarm_clock,
                &cockpit->lock
            );
        }
        cockpit->working = true;
        pthread_mutex_unlock(&cockpit->lock);

        // Woken up. Should worker die?
        pthread_mutex_lock(&cockpit->lock);
        if(true == cockpit->should_die) {
            pthread_mutex_unlock(&cockpit->lock);
            return;
        }

        // Worker should not die. Work.
        pthread_mutex_lock(&cockpit->lock);
        cockpit->working = false;
        pthread_mutex_unlock(&cockpit->lock);
    }
}

void kill_worker(struct worker_cockpit * cockpit) {
    pthread_mutex_lock(&cockpit->lock);
    cockpit->should_die = true;
    pthread_mutex_unlock(&cockpit->lock);

    return;
}
