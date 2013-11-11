#include <linux/init.h> // For module_* functions and the __init macro
#include <linux/kernel.h> // For printk function (and more?)
#include <linux/module.h> // For MODULE_* functions
#include <linux/proc_fs.h> // For proc_* functions
#include "proc_file.h" // For `proc_file_operations` variable

#define PROC_FILE_NAME "example_proc_file"
#define INIT_MESSAGE "creating proc file " PROC_FILE_NAME
#define EXIT_MESSAGE "destroying proc file " PROC_FILE_NAME

// Both `example_module_init()` and `example_module_exit()` need to reference
// the same proc file. This file-wide pointer allows them to do so.
struct proc_dir_entry * proc_file;

/* Create proc file `proc_file`. */
int __init example_module_init(void) {
    printk(KERN_INFO INIT_MESSAGE);
    proc_file = proc_create(PROC_FILE_NAME, 0, NULL, &proc_file_operations);
    printk(KERN_INFO "done " INIT_MESSAGE);
    return 0;
}

/* Destroy proc file `proc_file`. */
void __exit example_module_exit(void) {
    printk(KERN_INFO EXIT_MESSAGE);
    proc_remove(proc_file);
    printk(KERN_INFO "done " EXIT_MESSAGE);
    return;
}

// Define which functions should be run "at kernel boot time or module
// insertion" and "when driver is destroyed", respectively.
module_init(example_module_init);
module_exit(example_module_exit);

// Take care of some documentation tasks.
MODULE_LICENSE("GPL");
MODULE_AUTHOR(
    "Peter C. Chapin <PChapin@vtc.vsc.edu>, "
    "Jeremy Audet <Ichimonji10@gmail.com>"
);
MODULE_DESCRIPTION(
    "A simple module that creates a proc file named " PROC_FILE_NAME
);
