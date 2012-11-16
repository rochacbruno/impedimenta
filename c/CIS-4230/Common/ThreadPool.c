/*! \file    ThreadPool.c
    \brief   Implementation of a thread pool class.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

*/

#include <stdlib.h>
#include <sys/sysinfo.h>  // For get_nprocs( ).
#include "ThreadPool.h"

#define FALSE 0
#define TRUE  1

// ThreadInformation class
// =======================

//! Used by the ThreadPool class to track the activity of one worker thread.
struct ThreadInformation {
    pthread_mutex_t lock;         // Enforce mutual exclusion to this ThreadInformation.
    pthread_t       worker;       // The actual thread described by this ThreadInformation.
    void *( *work_function )( void * );  // Function to execute...
    void           *arguments;           // ... using this argument.
    void           *result;              // ... putting result here.
    int             fresh_work;   // True if thread has work ready (or work in progress).
    int             fresh_result; // True if there is a new result to pick up.
    int             die;          // True if the thread is supposed to terminate.
    pthread_cond_t  work_ready;
    pthread_cond_t result_ready;
};


//! Function that dispatches worker threads.
/*!
 * This function is executed by each thread. It waits for work to do. When a ThreadPool is not
 * busy, all its worker threads are blocked waiting for work here.
 */
static void *dispatching_function( void *arg )
{
    void *arguments;
    void *result;
    struct ThreadInformation *my_information = (struct ThreadInformation *)arg;

    while( 1 ) {
        pthread_mutex_lock( &my_information->lock );

        // It is necessary to check fresh_result in the loop condition below so that when the
        // thread finishes doing some work it doesn't immediately think there is more work. The
        // value of fresh_work is TRUE until the result is picked up; that condition is used to
        // indicate which threads are currently active. See thread_pool_start_work().
        //
        // Thread termination is handled by a 'die' flag to ensure that the terminated thread is
        // actually finished using the other synchronization primitives before they are cleaned
        // up. See thread_information_destroy().
        //
        while( (my_information->fresh_work   == FALSE ||
                my_information->fresh_result == TRUE) && !my_information->die )
            pthread_cond_wait( &my_information->work_ready, &my_information->lock );
        if( my_information->die ) break;
        arguments = my_information->arguments;
        pthread_mutex_unlock( &my_information->lock );

        result = my_information->work_function( arguments );

        pthread_mutex_lock( &my_information->lock );
        my_information->result = result;
        my_information->fresh_result = TRUE;
        pthread_cond_signal( &my_information->result_ready );
        pthread_mutex_unlock( &my_information->lock );
    }
    return NULL;
}


static void thread_information_initialize( struct ThreadInformation *this )
{
    this->work_function = NULL;
    this->arguments     = NULL;
    this->result        = NULL;
    this->fresh_work    = FALSE;
    this->fresh_result  = FALSE;
    this->die           = FALSE;

    pthread_mutex_init( &this->lock, NULL );
    pthread_cond_init( &this->work_ready, NULL );
    pthread_cond_init( &this->result_ready, NULL );
    pthread_create( &this->worker, NULL, dispatching_function, this );
}


static void thread_information_destroy( struct ThreadInformation *this )
{
    // Tell the thread to die and wait until it does.
    pthread_mutex_lock( &this->lock );
    this->die = TRUE;
    pthread_cond_signal( &this->work_ready );  // It's a kind of work to die.
    pthread_mutex_unlock( &this->lock );
    pthread_join( this->worker, NULL );

    // Clean up the synchronization primitives.
    pthread_mutex_destroy( &this->lock );
    pthread_cond_destroy( &this->work_ready );
    pthread_cond_destroy( &this->result_ready );
}


void thread_pool_initialize( struct ThreadPool *this )
{
    int i;

    this->pool_size = get_nprocs( );
    sem_init( &this->worker_count, 0, 0 );
    this->thread_information =
        (struct ThreadInformation *)malloc( this->pool_size * sizeof(struct ThreadInformation) );

    // Get the threads going and count them as we do.
    for( i = 0; i < this->pool_size; ++i ) {
        thread_information_initialize( &this->thread_information[i] );
        sem_post( &this->worker_count );
    }
}


void thread_pool_destroy( struct ThreadPool *this )
{
    int i;

    // Clean up the threads. This waits until they have all completed any work in progress.
    for( i = 0; i < this->pool_size; ++i ) {
        thread_information_destroy( &this->thread_information[i] );
    }
    free( this->thread_information );
    sem_destroy( &this->worker_count );
}


int thread_pool_count( struct ThreadPool *this )
{
    return this->pool_size;
}


threadid_t thread_pool_start_work(
    struct ThreadPool *this, void *( *work_function )( void * ), void *arg )
{
    int i;
    int abort = FALSE;

    // Be sure there is a free worker thread.
    sem_wait( &this->worker_count );

    // Loop over all threads in the pool.
    for( i = 0; i < this->pool_size; ++i ) {
        pthread_mutex_lock( &this->thread_information[i].lock );

        // Does thread 'i' need work?
        if( this->thread_information[i].fresh_work == FALSE ) {

            // Give it the work it wants.
            this->thread_information[i].work_function = work_function;
            this->thread_information[i].arguments     = arg;
            this->thread_information[i].fresh_work    = TRUE;
            pthread_cond_signal( &this->thread_information[i].work_ready );
            abort = TRUE;
        }
        pthread_mutex_unlock( &this->thread_information[i].lock );

        // Once we've assigned work we have to leave.
        if( abort ) break;
    }
    return i;
}


void *thread_pool_work_result( struct ThreadPool *this, threadid_t ID )
{
    void *result;

    pthread_mutex_lock( &this->thread_information[ID].lock );

    // Wait until there is a fresh result.
    while( !this->thread_information[ID].fresh_result )
        pthread_cond_wait(
            &this->thread_information[ID].result_ready,
            &this->thread_information[ID].lock );

    // Clear it out of the thread information structure.
    result = this->thread_information[ID].result;
    this->thread_information[ID].fresh_result = FALSE;
    this->thread_information[ID].fresh_work   = FALSE;

    pthread_mutex_unlock( &this->thread_information[ID].lock );

    // Increment the number of available workers.
    sem_post( &this->worker_count );
    return result;
}
