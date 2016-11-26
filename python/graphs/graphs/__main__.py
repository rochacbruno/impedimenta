# coding=utf-8
"""The entry point for ``graphs`` CLI."""
import argparse
import warnings
from itertools import chain

from graphs import Graph, prim, get_component_msts


def main():
    """Parse arguments, read in and analyze a graph, and print the analysis."""
    parser = argparse.ArgumentParser(
        prog='python -m graphs',
        description='''\
        Read in and analyze a weighted, directed graph. Print an analysis of
        the graph to stdout.
        ''',
    )
    parser.add_argument(
        'file',
        help='The file containing a graph description.',
        type=str,
    )
    parser.add_argument(
        '--analysis',
        help='Which type of analysis should be printed?',
        choices=('prose', 'full-graph', 'alt-full-graph', 'component-graph'),
        default='prose',
    )
    args = parser.parse_args()

    # We do work that may not be needed. An application intended for real world
    # use should be smarter about doing work. But this algorithm is intended
    # for educational purposes, and clarity is more important than efficiency.
    full_graph = Graph()
    full_graph.read_file(args.file)
    comp_graph = full_graph.get_component_graph()

    if args.analysis == 'prose':
        print(full_graph.to_prose())
    elif args.analysis == 'full-graph':
        highlight = tuple(chain.from_iterable(get_component_msts(full_graph)))
        print('digraph full {\n\n' + full_graph.to_dot(highlight) + '}\n')
    elif args.analysis == 'alt-full-graph':
        highlight = prim(full_graph, full_graph.get_components()[-1][0])
        print('digraph alt_full {\n\n' + full_graph.to_dot(highlight) + '}\n')
    elif args.analysis == 'component-graph':
        highlight = prim(comp_graph, comp_graph.get_components()[-1][0])
        print('digraph component {\n\n' + comp_graph.to_dot(highlight) + '}\n')
    else:
        warnings.warn('Unhandled argument: {}'.format(args.analysis))


if __name__ == '__main__':
    exit(main())
