#include <stdio.h>
#include <pthread.h>

#define NUM_THREADS 10

/* Prints out "Hello, world!" and the argument passed in. Should be called from
 * a thread. Argument should be a pointer to an integer.
 */
void * say_hello(void * arg) {
    int hello_id = *(int *)arg; // dereference pointer to int
    printf("Hello, world! (thread arg: %d)\n", hello_id);
    return NULL;
}

/* Creates NUM_THREADS threads, joins them, and prints their return vals. */
int main(void) {
    pthread_t   thread_ID[NUM_THREADS];
    int         args[NUM_THREADS];
    void *      ret_vals[NUM_THREADS];

    for(int i = 0; i < NUM_THREADS; i++) {
        args[i] = i;
        pthread_create(&thread_ID[i], NULL, say_hello, &args[i]);
    }
    for(int i = 0; i < NUM_THREADS; i++) {
        printf("joining thread %d\n", i);
        pthread_join(thread_ID[i], &ret_vals[i]);
        printf("thread %d returned: %d\n", i, ret_vals[i]);
    }

    return 0;
}
