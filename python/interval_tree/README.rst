Interval Tree
=============

This package contains an interval tree, implemented as an augmented red-black
tree. Each tree node represents a concrete interval, and the tree can be used to
efficiently find all nodes containing a specific concrete interval.

This has been done for Advanced Algorithms and Data Structures (CIS-5050-TW1)
programming assignment #1.

Requirements, Installation and Usage
------------------------------------

This package requires Python 3. It has been tested only with Python 3.5, but
should work with 3.4 and above. Only packages in the standard library are used;
no third-party packages or non-Python tools are required.

There is no installation procedure.

To use the application, execute::

    python3 -m interval_tree

No options may be passed to the application.

When the application is called, a semi-random augmented red-black tree will be
generated in memory. In addition, a semi-random interval will be generated, and
all overlapping intervals in the tree will be found. A Graphviz-compatible DOT
script representing the tree and the interval search will be printed. It can be
compiled to an image on-the-fly with::

    python3 -m interval_tree | dot -Tsvg -o ~/Documents/tree.svg

By default, the intervals consist of integer pairs. However, the interval tree
is type-agnostic, and any comparable data may be used.
``interval_tree/__main__.py`` includes code for using dates.

Implementation Notes
--------------------

The interval tree lacks a ``delete`` method. It was found to be unnecessary for
the goals of this assignment. The interval tree's ``search`` method was removed
after implementation for similar reasons.

Unit tests are present, but not comprehensive. Most notably, they do not verify
node colorings, node maximums or the ``overlapping_intervals`` function. These
aspects of the application were eyeballed for correctness.

The module name ``interval_tree.classes`` seems ugly.

The efficiency of the interval tree's ``overlapping_intervals`` function is
interesting to define. A kludgy method of measuring its efficiency is to apply
the following patch. This patch causes the graph to list the total number of
nodes visited by the function.

.. code-block:: diff

    diff --git a/interval_tree/__main__.py b/interval_tree/__main__.py
    index 315f27d..3bd913a 100644
    --- a/python/interval_tree/interval_tree/__main__.py
    +++ b/python/interval_tree/interval_tree/__main__.py
    @@ -26,7 +26,7 @@ def main():
             'label="The root node is marked in yellow.\n'
             'The interval {} overlaps the following intervals:\n'
             '{}"'
    -    ).format(query, ', '.join((str(interval) for interval in results)))
    +    ).format(query, len(results))
         print('\n'.join(('digraph interval_tree {', tree.as_dot(), label, '}')))


    diff --git a/interval_tree/classes.py b/interval_tree/classes.py
    index 4c8f098..13c7169 100644
    --- a/python/interval_tree/interval_tree/classes.py
    +++ b/python/interval_tree/interval_tree/classes.py
    @@ -302,7 +302,7 @@ class IntervalTree(object):
             if node.interval.overlaps(interval):
                 matches = [node.interval]
             else:
    -            matches = []
    +            matches = [node.interval]

             # check right tree
             if interval < node.interval:
