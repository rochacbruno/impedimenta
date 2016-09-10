Maximum Subarray
================

This package contains algorithms for finding the maximum subarray of an array.
Three algorithms are implemented: brute-force, recursive, and a hybrid which
starts as recursive and switches to brute force when the problem sizes become
small enough.

This has been done for Exercise 4.1-3 in *Introduction to Algorithms, Third
Edition*, by Cormen, Leiseron, Rivest and Stein.

Requirements, Installation and Usage
------------------------------------

This package requires Python 3. It has been tested only with Python 3.5, but
should work with 3.3 and above. Only packages in the standard library are used;
no third-party packages or non-Python tools are required.

There is no installation procedure. (See the `Implementation Notes`_.)

For usage instructions, execute::

    python3 -m max_sub --help

A simple use case is:

.. code-block:: sh

    make arrays
    python -m max_sub recursive arrays/10000.txt

Or, for more interesting results:

.. code-block:: sh

    make arrays
    for alg in recursive hybrid brute-force; do
        for f in arrays/*; do
            python -m max_sub "$alg" "$f"
        done > "${alg}.txt"
    done

.. WARNING:: The brute-force algorithm takes a substantial amount of time to
    analyze the larger files. Consider *not* using the brute-force algorithm to
    on arrays with 1,000 elements or more.

Implementation Notes
--------------------

This package is reasonably well formed. The addition of a simple ``setup.py``
file would allow for installation and distribution. (Of course, that would imply
a few more tasks, such as choosing a license and implementing a version scheme.)
Unfortunately, "well formed" implies that some amount of boilerplate is present.

Analysis
--------

The hybrid algorithm usually shows an advantage over the recursive algorithm
when analyzing small arrays. When analyzing larger arrays, the difference in
runtime is drowned out by other factors. Here's an example of the running time
for several arrays:

==========  =================  ==============
Array size  Recursive runtime  Hybrid runtime
==========  =================  ==============
1           0.000008           0.000016
2           0.000024           0.000020
3           0.000039           0.000025
4           0.000049           0.000032
5           0.000062           0.000038
6           0.000102           0.000045
7           0.000069           0.000043
8           0.000079           0.000044
9           0.000090           0.000056
10          0.000100           0.000063
20          0.000193           0.000191
30          0.000282           0.000303
40          0.000377           0.000372
50          0.000478           0.000466
60          0.000519           0.000569
70          0.000582           0.000562
80          0.000772           0.000765
90          0.000859           0.000835
100         0.000940           0.000950
200         0.001800           0.001872
300         0.002959           0.002915
400         0.003904           0.004044
500         0.005023           0.004963
600         0.006078           0.007411
700         0.007116           0.007107
800         0.008139           0.008009
900         0.009805           0.009161
1000        0.010232           0.009945
==========  =================  ==============

It is likely possible to produce even greater gains by setting the crossover
point more carefully.
