# coding=utf-8
"""The entry point for ``interval_tree`` CLI."""
import argparse
import datetime
from random import randint

from interval_tree.classes import Interval, Node, IntervalTree


def main():
    """Parse arguments, generate a random tree, and describe it with DOT."""
    parser = argparse.ArgumentParser(
        prog='python -m interval_tree',
        description='''\
        Generate a semi-random interval tree. Generate a DOT script describing
        the entire tree, and print that description to stdout.
        ''',
    )
    parser.parse_args()

    # The interval tree is type-agnostic. To demonstrate, change this.
    gen_interval = _gen_integer_interval
    # gen_interval = _gen_date_interval

    tree = IntervalTree()
    for _ in range(10):
        tree.insert(Node(gen_interval()))
    query = gen_interval()
    results = tree.overlapping_intervals(query)
    label = (
        'label="The root node is marked in yellow.\n'
        'The interval {} overlaps the following intervals:\n'
        '{}"'
    ).format(query, ', '.join((str(interval) for interval in results)))
    print('\n'.join(('digraph interval_tree {', tree.as_dot(), label, '}')))


def _gen_integer_interval():
    integers = [randint(-50, 50) for _ in range(2)]
    integers.sort()
    return Interval(*integers)


def _gen_date_interval():
    # python3 -m venv env
    # source env/bin/activate
    # pip install faker
    # …
    # deactivate
    # rm -rf env
    from faker import Factory  # pylint:disable=import-error
    factory = Factory.create()
    dates = [
        datetime.datetime.strptime(factory.date(), '%Y-%m-%d')
        for _ in range(2)
    ]
    dates = [datetime.date(date.year, date.month, date.day) for date in dates]
    dates.sort()
    return Interval(*dates)


if __name__ == '__main__':
    exit(main())
