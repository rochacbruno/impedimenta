/*! \file    ThreadPool.h
    \brief   Interface to a thread pool type.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

The thread pool defined here uses Posix threads as the underlying thread API.
*/

#ifndef THREADPOOL_H
#define THREADPOOL_H

#include <pthread.h>

// ThreadInformation class
// =======================

//! Used by the ThreadPool class to track the activity of one worker thread.
struct ThreadInformation {
    pthread_mutex_t    lock;         // Enforce mutual exclusion to this ThreadInformation.
    pthread_t          worker;       // The actual thread described by this ThreadInformation.
    void *( *work_function )( void * );  // Function to execute...
    void              *arguments;        // ... using this argument.
    void              *result;           // ... putting result here.
    bool               fresh_work;   // True if thread has work ready (or being processed).
    bool               fresh_result; // True if there is a new result to pick up.
    pthread_barrier_t *termination;  // Points at object to synchronize thread termination.
    pthread_cond_t     work_ready;
    pthread_cond_t     result_ready;
};

void thread_information_initialize( struct ThreadInformation *this );
void thread_information_destroy( struct ThreadInformation *this );


// ThreadPool class
// ================

//! Manages a pool of pre-created threads. It is permitted to have multiple pool objects.
struct ThreadPool {
    int                pool_size;                // Number of threads in the pool.
    sem_t              worker_count;             // Number of available workers.
    ThreadInformation *thread_information;       // Points at dynamic array of ThreadInformation.
    pthread_barrier_t  synchronize_termination;  // Used during pool shutdown.
};

//! Type used to hold thread ID values in the scope of a particular pool.
typedef int threadid_t;

void thread_pool_initialize( struct ThreadPool *this );
void thread_pool_destroy( struct ThreadPool *this );
int  thread_pool_count( struct ThreadPool *this );
threadid_t thread_pool_start_work(
    struct ThreadPool *this, void *( *work_function )( void * ), void *arg );
int  thread_pool_work_result( struct ThreadPool *this, threadid_t ID );

#endif
