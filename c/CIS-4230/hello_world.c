#include <stdio.h>
#include <pthread.h>

void * say_hello(void * arg) {
    int * hello_id = (int *)arg;

    printf("Hello, world! (hello_id %d)\n", *hello_id);

    return NULL;
}

int main(void) {
    pthread_t thread_ID;
    void * exit_status;
    int pass_in = 42;

    pthread_create(&thread_ID, NULL, say_hello, &pass_in);
    printf("Hello, world! (main)\n");
    pthread_join(thread_ID, &exit_status);

    return 0;
}
