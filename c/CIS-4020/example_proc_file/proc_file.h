/*------------------------------------------------------------------------------
This file declares a struct that implements the seq_file virtual file interface.
For more information on the seq_file interface, see:

* Documentation/filesystems/seq_file.txt (in the kernel source code)
* https://www.linux.com/learn/linux-training/44184-the-kernel-newbie-corner-kernel-debugging-with-proc-qsequenceq-files-part-3

The virtual file created is very simple: it contains an ascending set of even
numbers. The file is not of infinite size, and the exact limits on its size are
maintained interally.
------------------------------------------------------------------------------*/
#ifndef MY_PROCFILE_H
#define MY_PROCFILE_H

// For seq_* structs and functions
#include <linux/seq_file.h>
// Implements the seq_file interface.
extern struct file_operations proc_file_operations;

#endif // #ifndef MY_PROCFILE_H
