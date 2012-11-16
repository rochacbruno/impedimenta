#
# Makefile for the CIS-4230 Solar System Simulator unit test program.
#

CC=clang
CFLAGS=-c -emit-llvm -I..
LD=llvm-ld
LDFLAGS=-native -L/usr/lib/i386-linux-gnu -lpthread -lcunit -lncurses
SOURCES=main.c string_tests.c thread_pool_tests.c tree_tests.c
OBJECTS=$(SOURCES:.c=.bc)
EXECUTABLE=Check

%.bc:	%.c
	$(CC) $(CFLAGS) $< -o $@

$(EXECUTABLE):	$(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) ../Common.bc -o $@

# File Dependencies
###################

main.bc:		main.c

string_tests.bc:	string_tests.c string_tests.h ../str.h

thread_pool_tests.bc:	thread_pool_tests.c thread_pool_tests.h ../ThreadPool.h

tree_tests.bc:		tree_tests.c tree_tests.h ../Tree.h


# Additional Rules
##################
clean:
	rm -f *.o *.bc *.s *.ll *~ $(EXECUTABLE)