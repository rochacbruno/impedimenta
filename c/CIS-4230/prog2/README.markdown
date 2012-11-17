Program 2
=========

Author: Jeremy Audet  
Professor: Peter Chapin  
Due: Fri Nov 16 2012

Question 1
----------
Analyze the serial version of Barnes-Hut to determine the percentage of time
expended in the octree construction phase vs the force computation and dynamics
update phase. To do this you may need to make use of timers as defined in
`Timer.h` in the Common library. Notice that those timers can be stopped and
started repeatedly, accumulating an overall time. You may need to adjust the
number of objects in the problem to make the recorded times long enough to
measure properly. What is the resolution on the timers defined by `Timer.h`?

Answer 1
--------
The program spends the vast majority of it's time working through the second for
loop in `time_step()`. A sample run-through of the program produces this:

    $ mpirun -np 1 MPI
    Starting stopwatch_self.
    time steps = 0
    time steps = 100
    time steps = 200
    Stopwatch stopped.
    Total time elapsed = 2468 milliseconds
    Years simulated = 0.034
    Total time steps = 300
    process 0 stopwatch1 = 25 milliseconds
    process 0 stopwatch2 = 2418 milliseconds

The output empirically demonstrates that the maximum resolution of a timer from
`Timer.h` is one millisecond.

Note: When the above output was obtained, the program did not yet perform any
significant MPI-related actions, such as broadcasting or gathering data. It is
essentially the same as the vanilla serial program, despite a contrary
appearance.

Question 2
----------
Parallelize Barnes-Hut using MPI as described above and measure how long each
node spends in the force computation and dynamics update phase. What is the
overall speed-up of the parallel version (you might try it with a number of
different nodes).

Answer 2
--------

Question 3
----------
MPI allows you to run multiple instances of a single threaded program on a node
to take advantage of multiple cores on that node. Is there an advantage to using
multiple threads, for example, with OpenMP, within the program? Try it and
compare the speed up you can obtain with a hybrid MPI/multi-threaded solution.

Answer 3
--------
