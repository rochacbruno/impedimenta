# Makefile for the add.cu program.
#
# Syntax is:
#
#     target: dependencies
#     (tab) system command
#
# $@ is left side of :
# $^ is right side of :
# $< is first item on right side of :

# Constants
###########
CC=gcc          # C compiler
CFLAGS=-c -Wall # C compiler flags
CUDAC=nvcc      # CUDA compiler
CUDAC_FLAGS=-c  # CUDA compiler flags
LD=nvcc         # linker
LDFLAGS=        # linker flags
EXECUTABLE=ADD  # executable name
OBJECTS=add.o   # objects in executable

# Rules
#######
$(EXECUTABLE): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)
%.o: %.c
	$(CC) $(CFLAGS) -o $@ $^
%.o: %.cu
	$(CUDAC) $(CUDAC_FLAGS) -o $@ $^

# File Dependencies
###################
add.o: add.cu

# Additional Rules
##################
clean:
	rm *.o $(EXECUTABLE)
