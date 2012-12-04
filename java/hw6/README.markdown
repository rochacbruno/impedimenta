Assignment 6
============

CIS-3050 Algorithms and Data Structures  
Due:  Dec 6th, in class  
Professor: Lesle Damon  
Student: Jeremy Audet  

Student Response
----------------

To generate documentation:

    javadoc dag_sorter -d </destination/directory>

To compile code:

    javac -Xlint -cp .:/usr/share/java/junit.jar dag_sorter/*.java

To execute unit tests:

    java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore \
    dag_sorter.TestNode dag_sorter.TestGraph

To read and sort a provided graph:

    java dag_sorter.ParseFile </path/to/file>

The output of `java dag_sorter.ParseFile </path/to/file>` is valid because each
node printed depends upon only preceding lines. That's... that's how topological
sorting works. Does anything more need to be said? I've included ASCII art for
all of the graphs, as you can see below. Note that my program works on graphs
for which multiple sources and sinks are present. Sample run:

    Script started on Mon 03 Dec 2012 11:47:46 PM EST
    $ find . -type f -name \*.class -delete
    $ java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore dag_sorter.Test{Node,Graph}
    JUnit version 4.11
    .......
    Time: 0.011

    OK (7 tests)

    $ for i in `seq 1 3`; do java dag_sorter.ParseFile graphs/graph${i}.txt; echo; done
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

    $ java dag_sorter.ParseFile graphs/smalltest.txt
    Discarding malformed line: #    1
    Discarding malformed line: #   / \
    Discarding malformed line: #  2   3
    Discarding malformed line: #   \ /
    Discarding malformed line: #    4
    1, 2, 3, 4
    $ java dag_sorter.ParseFile graphs/largetest.txt
    Discarding malformed line: #         1
    Discarding malformed line: #        /|\
    Discarding malformed line: #       / | \
    Discarding malformed line: #      2  3 |
    Discarding malformed line: #     / \/ \|
    Discarding malformed line: #     | |  10
    Discarding malformed line: #     | | /|
    Discarding malformed line: #     | |/ |
    Discarding malformed line: #     | 5  |
    Discarding malformed line: #     |/|  |
    Discarding malformed line: #     6 |  |
    Discarding malformed line: #    /|\|  /
    Discarding malformed line: #   / | 7 /
    Discarding malformed line: #   | | |/
    Discarding malformed line: #   \ \ 8
    Discarding malformed line: #    \ X|
    Discarding malformed line: #     9 \
    Discarding malformed line: #       4
    1, 2, 3, 10, 5, 6, 7, 8, 4, 9
    $ exit
    exit

    Script done on Mon 03 Dec 2012 11:48:45 PM EST
