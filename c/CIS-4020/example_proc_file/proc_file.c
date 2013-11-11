#include <linux/init.h> // For module_* functions
#include <linux/fs.h> // For file_operations struct
#include <linux/slab.h> // For kmalloc()
#include "proc_file.h"

// How large is the virtual file? This limit is entirely arbitrary.
#define PROC_FILE_SIZE 3

/*------------------------------------------------------------------------------
Declare the functions and define the structs that `proc_file_operations`
depends upon. `proc_file_operations` is declared in `proc_file.h`.
------------------------------------------------------------------------------*/

// Declare functions which implement the seq_file interface. Gather them into a
// struct.
void *my_seq_start(struct seq_file *s, loff_t *position);
int   my_seq_show (struct seq_file *s, void *v);
void *my_seq_next (struct seq_file *s, void *v, loff_t *position);
void  my_seq_stop (struct seq_file *s, void *v);
struct seq_operations my_seq_operations = {
    .start = my_seq_start,
    .show  = my_seq_show,
    .next  = my_seq_next,
    .stop  = my_seq_stop
};

// Define a file handling function and insert it into a struct containing
// several other predefined file handling functions.
int my_open(struct inode *inode, struct file *file) {
    return seq_open(file, &my_seq_operations);
}
struct file_operations proc_file_operations = {
    .owner   = THIS_MODULE,
    .open    = my_open,
    .read    = seq_read,
    .llseek  = seq_lseek,
    .release = seq_release
};

/*------------------------------------------------------------------------------
Define the functions declared above.
------------------------------------------------------------------------------*/

/* Given a position within the virtual file, create a recipe. If data should
 * exist at that point in the file, return the recipe. Otherwise, return NULL.
 */
void *my_seq_start(struct seq_file *s, loff_t *position) {
    // `loff_t` is an integer type
    loff_t * recipe = (loff_t *)kmalloc(sizeof(loff_t), GFP_KERNEL);

    if(NULL == recipe) // Did kmalloc() fail?
        return NULL;
    if(PROC_FILE_SIZE <= *position)
        return NULL;

    *recipe = *position;
    return recipe;
}

/* Use `recipe` to generate an even number, print it, and return 0.
 *
 * The relationship between `recipe` and the number produced is very simple.
 * Given 0, print 0; given 1, print 2; given 2, print 4; and so on.
 *
 * This function should never print more than a single page of output (as
 * determined by PAGE_SIZE). If more than one page of output is desired, split
 * that output between multiple calls to this function. If this function
 * produces more than one page of output, Bad Things happen (ideally, output is
 * simply truncated).
 */
int my_seq_show(struct seq_file *s, void *recipe) {
    loff_t value = *(loff_t *)recipe;
    value *= 2; // make even
    seq_printf(s, "%lld\n", value);
    return 0;
}

/* Increment the position within the virtual file. If data should exist at that
 * point in the file, update the recipe. Otherwise, return NULL.
 */
void *my_seq_next(struct seq_file *s, void *recipe, loff_t *position) {
    (*position) += 1;
    if(PROC_FILE_SIZE <= *position) {
        return NULL;
    }

    *((loff_t *)recipe) = *position;
    return recipe;
}

/* Free resources allocated by `my_seq_start()`. */
void my_seq_stop(struct seq_file *s, void *recipe) {
    kfree(recipe);
}
