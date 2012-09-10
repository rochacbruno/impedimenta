/*! \file    ThreadPool.c
    \brief   Implementation of a thread pool class.
    \author  Peter C. Chapin <PChapin@vtc.vsc.edu>

*/

#include <ThreadPool.h>

//! Function that dispatches worker threads.
/*!
 * This function is executed by each thread. It waits for work to do. When a ThreadPool is not
 * busy, all its worker threads are blocked waiting for work here.
 */
static void dispatching_function( struct ThreadPool *pool, void *arg )
{
}
