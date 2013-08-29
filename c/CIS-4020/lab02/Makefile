###########################################################################
# FILE        : Makefile
# LAST REVISED: 2011-08-29
# SUBJECT     : Basic makefile for building a Linux module.
###########################################################################

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
