Assignment 6
============

CIS-3050 Algorithms and Data Structures  
Due:  Dec 6th, in class  
Professor: Lesle Damon  
Student: Jeremy Audet  

Problem Description
-------------------

Your task is to read a file that contains the edges of an acyclic directed
graph. Vertices are labeled as positive integers from 1 to n. Every row
indicates an edge, the vertex label in first column is the tail and the vertex
label in second column is the head (recall the graph is directed, and the edges
are directed from the first column vertex to the second column vertex). So for
example, the a row may look like : "2 867". This just means that the vertex with
label 2 has an outgoing edge to the vertex with label 867

Your task is to code up the algorithm from the lecture for computing a
topological ordering for the graph using a depth first search algorithm, and to
run this algorithm on the given graph.

You should output the ordering in the form of an int array with the nodes in a
valid topological order. I will supply a some sample test files.

This assignment is due in class on Dec 6th. Please bring submit your code
electronically through moodle AND bring a paper copy of test console to class. I
will specify this output more completely when I give you the test file you are
expected to run.

This is a draft copy of the assignment check back later for the test files, and
a more complete specification of what your test should produce.

Student Response
----------------

To generate documentation:

    javadoc dag_sorter -d </destination/directory>

To compile code:

    javac -Xlint -cp .:/usr/share/java/junit.jar dag_sorter/*.java

To execute unit tests:

    java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore \
    dag_sorter.TestNode dag_sorter.TestGraph

To read and sort the provided graphs:

    java dag_sorter.SortFile </path/to/file>

Sample run:

    Script started on Mon 03 Dec 2012 05:05:33 PM EST
    $ javac -Xlint -cp .:/usr/share/java/junit.jar dag_sorter/*.java
    $ java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore dag_sorter.Test{Node,Graph}
    JUnit version 4.11
    .......
    Time: 0.011

    OK (7 tests)

    $ for i in `seq 1 3`; do java dag_sorter.SortFile graphs/graph${i}.txt; echo; done
    Discarding malformed line: #     1
    Discarding malformed line: #    / \
    Discarding malformed line: #   2   3
    Discarding malformed line: #  / \ / \
    Discarding malformed line: # 4   5   6
    1, 2, 4, 3, 5, 6

    Discarding malformed line: # 6   5   4
    Discarding malformed line: #  \ / \ /
    Discarding malformed line: #   3   2
    Discarding malformed line: #    \ /
    Discarding malformed line: #     1
    4, 5, 2, 6, 3, 1

    Discarding malformed line: # 5    7   3
    Discarding malformed line: #  \  / \ /|
    Discarding malformed line: #   11   8 |
    Discarding malformed line: #  /  \ /  |
    Discarding malformed line: # 2    9   10
    5, 7, 11, 2, 3, 8, 9, 10

    $ exit
    exit

    Script done on Mon 03 Dec 2012 05:06:05 PM EST
