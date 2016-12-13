# coding=utf-8
"""The entry point for ``string_matcher`` CLI."""
import argparse
import io
import textwrap

import string_matcher


def main():
    """Parse arguments. Maybe call string matching logic and print results."""
    parser = argparse.ArgumentParser(
        prog='python -m string_matcher',
        description='''\
        Read in a search pattern and a body of text, and determine whether the
        former is in the latter. Print the results to stdout.
        ''',
    )
    parser.add_argument('pattern', help='The pattern to search for.')
    parser.add_argument('text', help='The text to search.')
    args = parser.parse_args()
    indices = string_matcher.kmp_matcher(args.text, args.pattern)

    wrapper = textwrap.TextWrapper()
    with io.StringIO() as handle:
        if indices:
            handle.write(wrapper.fill(textwrap.dedent(
                '''\
                The pattern is present in the text at the following
                (zero-based) indices: {}
                '''.format(indices)
            )))
        else:
            handle.write(wrapper.fill(
                'The pattern is not present in the text.'
            ))
        print(handle.getvalue())


if __name__ == '__main__':
    exit(main())
