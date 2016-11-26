Graphs
======

This package contains a program that can read a weighed, directed graph from a
file, analyze the graph, and print a description derived from the analysis.

Requirements
------------

The file describing the graph must be encoded with ASCII. Each line in the file
describes a single weighted, directed edge, and each line must be in the
following format, with each of the three fields being separated by whitespace::

    source_vertex  destination_vertex  weight

The graph must abide by the following restrictions:

* It must be fully connected. (It need not be strongly connected.)
* Edge weights must be non-negative. (This program may function with negative
  weights, but it has not been tested with such.)

A sample graph abiding by these constraints is present in the current directory,
in ``graphs.txt``.

Behaviour
---------

When this program is run, it will read in the given graph and do the following:

1. Identify the strongly connected components of the graph.
2. Create a graph of strongly connected components.
3. Remove all duplicate edges between strongly connected components, leaving
   only the lowest-weight edges.
4. Find a minimum spanning tree for:

   * The strongly connected components.
   * Each individual component.

(The assignment says "The component level spanning tree should start from the
actual branched to." The meaning of this requirement is unclear, and in the
interest of pursuing certain real-life goals, it is ignored.)

By default, this program concludes by printing textual (ASCII) representations
of the following:

1. A list of the components in each strongly connected component.
2. The edges in a minimum spanning tree of strongly connected components.
3. The edges in minimum spanning trees of each strongly connected component.

This program can also print this information in DOT format.

Usage
-----

For help, call:

.. code-block:: sh

    python -m graphs --help

To generate a prose analysis of a graph, call one of the following:

.. code-block:: sh

    python -m graphs graph.txt
    python -m graphs --analysis prose graph.txt

To generate a DOT analysis of a graph, call one of the following:

.. code-block:: sh

    python -m graphs --analysis --full-graph graph.txt \
    | dot -Tsvg -o ~/full-graph.svg

    python -m graphs --analysis --alt-full-graph graph.txt \
    | dot -Tsvg -o ~/alt-full-graph.svg

    python -m graphs --analysis --component-graph graph.txt \
    | dot -Tsvg -o ~/component-graph.svg

Each DOT graph has the strongly connected components outlined. The full graph
has minimum spanning trees within each component highlighted. The alternate full
graph and component graphs have a minimum spanning tree for the entire graph
highlighted.
