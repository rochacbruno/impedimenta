#include "worker.h"
#include "thread_pool.h"
#include <stdio.h>
#include <sys/sysinfo.h>
#include <stdlib.h>

void * print_hello(void * arg) {
    int num = *(int *)arg;

    printf("hello from job: %d\n", num);

    return NULL;
}

int main() {
    const int NUM_JOBS = 1; //500; // arbitrary
    struct work_unit tasks[NUM_JOBS];
    struct thread_pool pool;

    thread_pool_init(&pool);
    for(int i = 0; i < NUM_JOBS; i++) {
        int * the_arg = malloc(sizeof(int));
        *the_arg = i;

        tasks[i].function = print_hello;
        tasks[i].arg = the_arg;
        tasks[i].result = NULL;
        thread_pool_give_work(&pool, tasks[i]);
    }
    thread_pool_die(&pool);
    for(int i = 0; i < NUM_JOBS; i++)
        free(tasks[i].arg);

    return 0;
}
