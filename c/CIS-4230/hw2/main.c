#include <stdio.h>
#include "worker.h"

void main() {
    struct worker_cockpit cockpit;

    worker_cockpit_init(cockpit);
    worker(cockpit);
    worker_kill(cockpit);

    return;
}
