#
# Makefile for the CIS-4230 Linear Equations project (Parallel version)
#

CC=clang
CFLAGS=-c -O -emit-llvm -I../../Common
LD=llvm-ld
LDFLAGS=-native -L/usr/lib/i386-linux-gnu -lpthread
SOURCES=solve_system.c linear_equations.c thread_pool/thread_pool.c \
    thread_pool/worker.c
OBJECTS=$(SOURCES:.c=.bc)
EXECUTABLE=Parallel

%.bc:	%.c
	$(CC) $(CFLAGS) $< -o $@

$(EXECUTABLE):	$(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) ../../Common/Common.bc -o $@

# File Dependencies
###################

solve_system.bc:	solve_system.c linear_equations.h
linear_equations.bc:	linear_equations.c linear_equations.h
thread_pool/thread_pool.bc:	thread_pool/thread_pool.c thread_pool/thread_pool.h
thread_pool/worker.bc:	thread_pool/worker.c thread_pool/worker.h

# Additional Rules
##################
clean:
	find . -type f \( -name "*.o" -o -name "*.bc" -o -name "*.s" -o -name "*.ll" \
    -o -name "*~" -o -name $(EXECUTABLE) \) -exec rm -f {} \;
