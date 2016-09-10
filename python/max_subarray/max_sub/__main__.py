# coding=utf-8
"""The entry point for ``max_sub`` CLI."""
import argparse
import time

from max_sub import algorithms


def main():
    """Parse arguments, run the subarray finder, and print a report."""
    parser = argparse.ArgumentParser(
        prog='python -m max_sub',
        description='''\
        Find the maximum subarray of an array of integers. When done, print the
        maximum subarray, the indices of the maximum subarray, the run time,
        and the name of the file. A reasonable effort is made to ensure that
        only the sorting algorithm's execution time is included in the printed
        run time. Actions such as reading a file off disk, printing text to a
        terminal or sleeping enforced by the operating system should not impact
        the reported time.
        ''',
    )
    parser.add_argument(
        'algorithm',
        help='The subarray-finding algorithm to use.',
        type=str,
        choices=('brute-force', 'recursive', 'hybrid'),
    )
    parser.add_argument(
        'file',
        help='A file containing integers, with one integer on each line.',
        type=str,
        nargs='+',
    )
    args = parser.parse_args()
    for path in args.file:
        integers = read_parse_file(path)
        algorithm = getattr(algorithms, args.algorithm.replace('-', '_'))
        start_time = time.process_time()
        max_sub = algorithm(integers)
        end_time = time.process_time()
        print('{} ({}-{}) {:.6f} {}'.format(
            max_sub.sum,
            max_sub.start,
            max_sub.end,
            end_time - start_time,
            path,
        ))


def read_parse_file(path):
    """Read a file. Return a tuple of integers."""
    with open(path) as handle:
        return tuple(int(line) for line in handle.read().split())


if __name__ == '__main__':
    exit(main())
