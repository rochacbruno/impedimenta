/* Make several system calls.

According to syscalls(2), "System  calls  are  generally not invoked directly,
but rather via wrapper functions in glibc (or perhaps some other library)."
For example, glibc provides the wrapper function `getpid`. However, system calls
can also be made directly. <sys/syscall.h> provides the `syscall` function for
doing just this.

Useful references:

* /usr/include/asm/unistd.h
* /usr/include/sys/syscall.h
* intro(2)
* syscall(2)
* syscalls(2)

*/
#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>

int main(void) {
    // warning: format '%ld' expects argument of type 'long int', but argument 2
    // has type '__pid_t' [-Wformat=]
    printf("getpid(): %ld\n", getpid());
    printf("syscall(__NR_getpid): %ld\n", syscall(__NR_getpid));
    printf("syscall(SYS_getpid): %ld\n", syscall(SYS_getpid));
    printf("syscall(39): %ld\n", syscall(39));
    printf("syscall(5000): %ld\n", syscall(5000));

    return(0);
}
