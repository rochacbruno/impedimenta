#include "worker.h"
#include "thread_pool.h"
#include <stdio.h>
#include <sys/sysinfo.h>
#include <stdlib.h>

// Recommended method of compilation::
//
//     gcc -std=c99 -pthread -Wall *.c
//
// Recomended method of testing (a single line of output should result)::
//
//     for i in `seq 1 100`; do ./a.out | wc; done | uniq

// print_hello will return (void *)(arg * RET_VAL_MULTIPLIER)
#define RET_VAL_MULTIPLER 2
// How many tasks will be thrown at the thread pool? I've sucessfully serviced
// 10,000,000 tasks. Beware, though -- it's the responsibility of main.c to
// malloc() and free() tasks in an intelligent way, and this program does not do
// that. If you set NUM_TASKS to 10000000, you may just eat up 1.8 GB of memory.
#define NUM_TASKS 10

void * print_hello(void * arg) {
    int num = *(int *)arg;
    int * ret_val = malloc(sizeof(int));
    *ret_val = RET_VAL_MULTIPLER * num;

    printf("hello from job: %d\n", num);

    return (void *)ret_val;
}

int main() {
    struct thread_pool pool;
    thread_pool_init(&pool);

    // Create tasks and hand them off to the thread pool.
    // Must malloc tasks instead of using [array] notation. Using [array]
    // notation will result in segfaults for large values of NUM_TASKS.
    struct worker_work * tasks = malloc(NUM_TASKS * sizeof(struct worker_work));
    for(int i = 0; i < NUM_TASKS; i++) {
        int * the_arg = malloc(sizeof(int));
        *the_arg = i;
        worker_work_init(&tasks[i]);
        tasks[i].function = print_hello;
        tasks[i].arg = the_arg;
        thread_pool_give_work(&pool, &tasks[i]);
    }

    // Read results as tasks are completed. Then free resources allocated to
    // each task.
    for(int i = 0; i < NUM_TASKS; i++) {
        pthread_mutex_lock(&tasks[i].lock);
        while(false == tasks[i].work_done)
            pthread_cond_wait(&tasks[i].alarm_clock, &tasks[i].lock);
        pthread_mutex_unlock(&tasks[i].lock);

        printf("task %d return val: %d (expected %d)\n",
            i,
            *(int *)tasks[i].result,
            RET_VAL_MULTIPLER * i
        );
        free(tasks[i].arg);
        free(tasks[i].result); // malloc'd inside print_hello
    }
    free(tasks);

    thread_pool_die(&pool);
    return 0;
}
