/****************************************************************************
FILE          : syscall_counters.c
LAST REVISION : 2012-07-22
SUBJECT       : Skeleton for a module that displays the system call counters.
PROGRAMMER    : (C) Copyright 2012 by Peter C. Chapin

This module creates a file in the /proc file system that users can read to
access the system call counters maintined by an appropriately modified kernel.
This file is part of Vermont Technical College's CIS-4020 (Operating Systems),
Lab #2.

Please send comments or bug reports to

     Peter C. Chapin
     Computer Information Systems
     Vermont Technical College
     Williston, VT 05495
     PChapin@vtc.vsc.edu
****************************************************************************/

#include <linux/module.h>   // Needed for any module.
#include <linux/kernel.h>   // Needed for printk, etc.
#include <linux/init.h>     // Needed for init/exit macros.
#include <linux/proc_fs.h>  // Needed for /proc stuff.
#include <linux/seq_file.h> // Needed for the seq_file stuff.

#define NUM_SYSCALLS 313
extern unsigned long long syscall_counts[];

// Declare the sequence handling functions that we define (below).
static void *counter_seq_start(struct seq_file *s, loff_t *pos);
static void *counter_seq_next (struct seq_file *s, void *v, loff_t *pos);
static void  counter_seq_stop (struct seq_file *s, void *v);
static int   counter_seq_show (struct seq_file *s, void *v);

// Gather our sequence handling functions into a seq_operations structure.
static struct seq_operations counter_seq_ops = {
    .start = counter_seq_start,
    .next  = counter_seq_next,
    .stop  = counter_seq_stop,
    .show  = counter_seq_show
};

// This function is called each time the application calls read(). It starts the
// process of accumulating data to fill the application buffer. Return a pointer
// representing the current item. Return NULL if there are no more items.
static void *counter_seq_start(struct seq_file *s, loff_t *record_number) {
    if(NUM_SYSCALLS <= *record_number) {
        return NULL;
    }
    return & syscall_counts[*record_number];
}

// This function is called to compute the next record in the sequence given a
// pointer to the current record (in bookmark). It returns a pointer to the new
// record (essentially, an updated bookmark) and updates *record_number
// appropriately. Return NULL if there are no more items.
static void *counter_seq_next(
    struct seq_file *s,
    void *bookmark,
    loff_t *record_number
) {
    (*record_number) += 1;
    if(NUM_SYSCALLS <= *record_number) {
        return NULL;
    }
    return & syscall_counts[*record_number];
}

// This function is called whenever an application buffer is filled (or when
// start or next returns NULL. It can be used to undo any special preparations
// done in start (such as deallocating auxillary memory that was allocated in
// start. In simple cases, you often do not need to do anything in this
// function.
static void counter_seq_stop(struct seq_file *s, void *bookmark) {
    ; // do nothing
}

// This function is called after next to actually compute the output. It can use
// various seq_... printing functions (such as seq_printf) to format the
// output. It returns 0 if successful or a negative value if it fails.
static int counter_seq_show(struct seq_file *s, void *bookmark) {
    // sc_location is the current location within `syscall_counts`
    unsigned long long * sc_location = (unsigned long long *)bookmark;
    int syscall_id = sc_location - syscall_counts;
    if(0 > seq_printf(s, "%d %lld\n", syscall_id, *sc_location)) {
        return -1;
    }
    return 0;
}

// Define the only file handling function we need.
static int counter_open(struct inode *inode, struct file *file) {
    return seq_open(file, &counter_seq_ops);
}

// Use the seq_file file handling functions for some of the file operations.
static struct file_operations counter_file_ops = {
    .owner   = THIS_MODULE,
    .open    = counter_open,
    .read    = seq_read, // Look at source of seq_read to understand protocol.
    .llseek  = seq_lseek,
    .release = seq_release
};

/*
 * counters_init
 *
 */
static int __init counters_init(void) {
    struct proc_dir_entry *entry;

    // Create a new entry in the /proc file system.
    if ((entry = create_proc_entry("syscall_counters", S_IFREG | S_IRUGO, NULL)) == NULL) {
        printk(KERN_ERR "syscall_counters NOT loaded. Error encountered\n");
        return -ENOMEM;
    }

    // Fill in some fields of the proc_entry. Note especially the file ops.
    entry->proc_fops = &counter_file_ops;
    entry->uid       = 0;
    entry->gid       = 0;
    entry->size      = 0; // A more appropriate size might be nice.

    printk(KERN_INFO "syscall_counters loaded\n");
    return 0;
}

/*
 * counters_exit
 *
 */
static void __exit counters_exit(void) {
    // Locate the named proc entry and unregister it.
    remove_proc_entry("syscall_counters", NULL);
    printk(KERN_INFO "syscall_counters unloaded\n");
}

// Specify which functions do initialization and cleanup.
module_init(counters_init);
module_exit(counters_exit);

// Take care of some documentation tasks.
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Peter C. Chapin <PChapin@vtc.vsc.edu>");
MODULE_DESCRIPTION("Module to display the system call counters.");
