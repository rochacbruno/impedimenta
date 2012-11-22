Assignment 5
============

Class: CIS-3050 Algorithms and Data Structures  
Professor: Leslie Damon  
Due: Nov 27th 1pm  

Instructions
------------

Your task is to implement two sorting algorithms and collect timings on them.
You need to implement one of the quadratic sorts (bubble, selection or
insertion), and one sort that is better than quadratic (heap, quicksort, merge
sort or radix sort). Each sort should be run a minimum of 10 times (and
preferably more), and you should display both the individual timings, plus the
average of all the runs of that sort.

The sorts will work over an `int[]` array containing integer values between 0
and 1000. You should run the sorts over arrays with at least 25,000 elements
(basically, you are striving for being able to collect reasonable timings for
your fastest sort, without having to wait forever for your slower sort. Unless
your machine is quite slow, you probably want something larger -- more in the
100,000 type range. 

To get you started, I have provided two classes, a `Timer` class, and a `Sort`
class that will serve as the superclass for your sorts. A link to download these
files can be found in moodle. Here is a more complete description:

The `Timer` class is used like this:

    Timer stopwatch = new Timer();   // creates a timer

    stopwatch.start();   // start the timer
    // do the stuff you want to time in here
    stopwatch.stop();  // stop the timer

    int elapsedMillis = stopwatch.time();  // read the timer -- how much
    time elapsed (in milliseconds) between start and stop. Remember to
    divide by 1000 to get seconds!

    stopwatch.reset();  // clear the timer before timing anything else

The `Sort` class is an abstract class. You will need to create a subclass
for each sort you implement. In your subclass, you will need to
implement a method, `public abstract void sort()`, that will actually perform
your sort. You will also need to implement all three constructors that exist in
`Sort`. Your subclass constructors will just call super() with the appropriate
arguments to invoke the superclass constructor.  This constructor will create a
randomized array of elements of the appropriate size, and fill it with a
randomized selection of ints between 0 and 1000. Feel free to play with the the
generateArray method in `Sort` if you'd like to have some negative values or
larger values in the array. You may use any of our resources to implement your
sort, but be sure to document the source of any code that you do not write. An
appropriate comment within the javadoc for the method is a good way to cite the
work.

Once you have implemented your sorts, you will need to create a separate class
with a main method to actually time the sorts. This is where you will control
the sort -- running it the specified number of times and timing it while you do.
The timing must be external to the sort method. In other words, start the timer
in main, call your sort, then stop the timer. Be sure to use constants/variables
where appropriate (for example, changing the number of elements in the array
should involve changing only one place in your code). Use good coding practices,
and comment your code where appropriate.

Be sure that when you collect your timings, you are only timing the actual
amount of time that the sort is running. Do not time the period when you are
filling the array or doing any other start up or concluding task.

As part of your implementation, you may want to write a printArray() method (and
put it in `Sort`) so that you can run with a small array and verify that your
sort is working correctly.

Reminder: be sure to document any help you get from other people/resources!

This assignment is due at class on Nov 27th. Please bring a paper copy of your
code (the two sort classes plus your main), plus a printout of the output of
your sorts. This print should include what the name of each sort is, the number
of elements being sorted, plus the timings. Also submit your source code file on
line via moodle. 

Response
--------

To generate documentation:

    javadoc sorts -d </destination/directory>

To compile code:

    javac -Xlint -cp .:/usr/share/java/junit.jar sorts/*.java

To execute unit tests:

    java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore sorts.TestInsertionSort
    TODO: add directions for testing second sort class
