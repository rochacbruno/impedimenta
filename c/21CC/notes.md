Makefiles
=========

The POSIX-standard make recipe for compiling a ".o" object file from a ".c"
source code file is:

    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $*.c

The GNU make recipe for compiling an executable file from object files is:

    $(CC) $(LDFLAGS) $(OBJECTS) $(LDLIBS)

Compilation and Linking
=======================

It is possible to compile and link a file as two separate steps. For example:

    c99 -c -o hello.o hello.c
    c99 -o hello hello.o
