#!/usr/bin/env python
# coding=utf-8
"""Print a table for finding a longest common subsequence.

.. WARNING:: The pretty-printing logic doesn't cope well with sequences of
    eleven characters or more.
"""
import argparse


def main():
    """Parse arguments, generate an LCS table, and pretty-print the table."""
    # Get sequences from user
    parser = argparse.ArgumentParser(
        prog='lcs-table.py',
        description='''\
        Print a table for finding the longest common subsequence of two
        sequences. If only one sequence is passed, the second sequence is
        assumed to be the reverse of the first.
        ''',
    )
    parser.add_argument('x_sequence', metavar='x-sequence')
    parser.add_argument(
        'y_sequence',
        metavar='y-sequence',
        nargs='?',
        default=None
    )
    args = parser.parse_args()
    x_seq = [_ for _ in args.x_sequence]
    if args.y_sequence is None:
        y_seq = x_seq.copy()
        y_seq.reverse()
    else:
        y_seq = [_ for _ in args.y_sequence]

    # Find and print LCS of sequences
    #
    # A nice improvement would be to push the pretty-printing logic into its
    # own function.
    values, arrows = find_lcs(x_seq, y_seq)
    print(
        'y y   {}  ← x index'
        .format('  '.join(str(i) for i in range(len(x_seq))))
    )
    print(
        '↓ ↓   {}  ← x sequence'
        .format('  '.join(str(i) for i in x_seq))
    )
    print('    ┌{}'.format('───' * len(x_seq)))
    for y_index, y in enumerate(y_seq):
        print('{} {} │'.format(y_index, y), end='')
        for x_index in range(len(x_seq)):
            print(' {}{}'.format(
                arrows[y_index][x_index],
                values[y_index][x_index],
            ), end='')
        print()


def find_lcs(x_seq, y_seq):
    """Generate the a pair of tables for finding an LCS.

    Return a ``(values_table, arrows_table)`` two-tuple. The two tables are
    identically sized.
    """
    values = []
    for y_index in range(len(y_seq)):
        row = [None for x_index in range(len(x_seq))]
        values.append(row)

    arrows = []
    for y_index in range(len(y_seq)):
        row = [None for x_index in range(len(x_seq))]
        arrows.append(row)

    def get_value(y_index, x_index):
        if y_index < 0 or x_index < 0:
            return 0
        else:
            return values[y_index][x_index]

    for y_index, y in enumerate(y_seq):  # select row
        for x_index, x in enumerate(x_seq):  # select column
            north = get_value(y_index - 1, x_index)
            west = get_value(y_index, x_index - 1)
            north_west = get_value(y_index - 1, x_index - 1)
            if x == y:
                values[y_index][x_index] = north_west + 1
                arrows[y_index][x_index] = '↖'
            elif north >= west:
                values[y_index][x_index] = north
                arrows[y_index][x_index] = '↑'
            else:
                values[y_index][x_index] = west
                arrows[y_index][x_index] = '←'

    return values, arrows


if __name__ == '__main__':
    exit(main())
