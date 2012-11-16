#
# Makefile for the CIS-4230 Solar System Simulator project (Serial version)
#

CC=clang
CFLAGS=-c -O -emit-llvm -I../Common
LD=llvm-ld
LDFLAGS=-native -L/usr/lib/i386-linux-gnu
SOURCES=main.c Initialize.c Object.c
OBJECTS=$(SOURCES:.c=.bc)
EXECUTABLE=BarnesHut

%.bc:	%.c
	$(CC) $(CFLAGS) $< -o $@

$(EXECUTABLE):	$(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) ../Common/Common.bc -o $@

# File Dependencies
###################

main.bc:	main.c

Initialize.bc:	Initialize.c

Object.bc:	Object.c

# Additional Rules
##################
clean:
	rm -f *.o *.bc *.s *.ll *~ $(EXECUTABLE)
