#include <linux/init.h> // For module_* functions
#include <linux/kernel.h> // For printk function (and more?)
#include <linux/module.h> // For MODULE_* functions

/* Load this module into the kernel. */
int __init my_module_init(void) {
    printk(KERN_INFO "example module inserted\n");
    return 0;
}

/* Unload this module from the kernel. */
void __exit my_module_exit(void) {
    printk(KERN_INFO "example module removed\n");
}

// Define which functions should be run "at kernel boot time or module
// insertion" and "when driver is removed", respectively.
module_init(my_module_init);
module_exit(my_module_exit);

// Take care of some documentation tasks.
MODULE_LICENSE("GPL");
MODULE_AUTHOR(
    "Peter C. Chapin <PChapin@vtc.vsc.edu>, "
    "Jeremy Audet <Ichimonji10@gmail.com"
);
MODULE_DESCRIPTION("A simple module that prints several messages with printk.");
