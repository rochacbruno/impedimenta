#
# Makefile for the CIS-4230 Linear Equations project (Serial version)
#

CC=clang
CFLAGS=-c -O -emit-llvm -I../../Common
LD=llvm-ld
LDFLAGS=-native -L/usr/lib/i386-linux-gnu -lpthread
SOURCES=solve_system.c linear_equations.c
OBJECTS=$(SOURCES:.c=.bc)
EXECUTABLE=Serial

%.bc:	%.c
	$(CC) $(CFLAGS) $< -o $@

$(EXECUTABLE):	$(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) ../../Common/Common.bc -o $@

# File Dependencies
###################

solve_system.bc:	solve_system.c linear_equations.h

linear_equations.bc:	linear_equations.c linear_equations.h

# Additional Rules
##################
clean:
	rm -f *.o *.bc *.s *.ll *~ $(EXECUTABLE)
