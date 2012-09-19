#include "worker.h"
#include "thread_pool.h"
#include <stdio.h>
#include <sys/sysinfo.h>
#include <stdlib.h>

void * print_hello(void * arg) {
    int num = *(int *)arg;
    int * ret_val = malloc(sizeof(int));
    *ret_val = num;

    printf("hello from job: %d\n", num);

    return (void *)ret_val;
}

int main() {
    const int NUM_JOBS = 19; // arbitrary
    struct worker_work tasks[NUM_JOBS]; // FIXME: malloc
    struct thread_pool pool;

    thread_pool_init(&pool);
    for(int i = 0; i < NUM_JOBS; i++) {
        int * the_arg = malloc(sizeof(int));
        *the_arg = i;

        tasks[i].function = print_hello;
        tasks[i].arg = the_arg;
        thread_pool_give_work(&pool, &tasks[i]);
    }
    thread_pool_die(&pool);
    for(int i = 0; i < NUM_JOBS; i++) {
        printf("job %d return val: %d\n", i, *(int *)tasks[i].result);
        free(tasks[i].arg);
        free(tasks[i].result);
    }

    return 0;
}
