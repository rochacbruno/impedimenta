#
# Makefile for the library.
#

CC=clang
CFLAGS=-c -O -emit-llvm
LD=llvm-ld
LDFLAGS=-link-as-library
SOURCES=ProblemFile.c str.c Timer.c Tree.c Vector3.c
OBJECTS=$(SOURCES:.c=.bc)
LIBRARY=Common.bc

%.bc:	%.c
	$(CC) $(CFLAGS) $< -o $@

$(LIBRARY):	$(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@

# File Dependencies
###################

ProblemFile.bc:	ProblemFile.c

str.bc:		str.c

Timer.bc:	Timer.c environ.h

Tree.bc:	Tree.c

Vector3.bc:	Vector3.c

# Additional Rules
##################
clean:
	rm -f *.o *.bc *.a *.s *.ll *~ $(LIBRARY)
