################################################################################
# Build a module for the Linux kernel.
#
# This makefile hooks in to the kernel build system to create a kernel module.
# The source code for the currently running kernel must be installed. If you
# wish to customize the name of the module produced or update its dependencies,
# edit the Kbuild file.
#
# See also:
# * https://www.gnu.org/software/make/manual/make.html
# * https://www.kernel.org/doc/Documentation/kbuild/makefiles.txt
################################################################################

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
