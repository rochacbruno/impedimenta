#!/usr/bin/env python3
# coding=utf-8
"""Generate text files containing integers, in an ``./arrays`` directory."""
from random import randint


def main():
    """Generate text files containing integers, in an ``./arrays`` dir.

    ``arrays/1.txt`` will contain one integer, ``arrays/2.txt`` will contain
    two integers, etc.
    """
    with open('arrays/1.txt', 'w') as handle:
        handle.write(str(randint(-1000, 1000)) + '\n')
    # Iterate through loops like:
    #
    # for i in range(1, 10, 1):
    # for i in range(10, 100, 10):
    for power_of_ten in (1, 10, 100, 1000):
        for i in range(power_of_ten, power_of_ten * 10, power_of_ten):
            with open('arrays/{}.txt'.format(i), 'w') as handle:
                for _ in range(i):
                    handle.write(str(randint(-1000, 1000)) + '\n')
    with open('arrays/10000.txt', 'w') as handle:
        for _ in range(10000):
            handle.write(str(randint(-1000, 1000)) + '\n')


if __name__ == '__main__':
    exit(main())
