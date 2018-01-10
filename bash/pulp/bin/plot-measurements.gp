#!/usr/bin/gnuplot
set terminal png
set xlabel "iteration"
set ylabel "execution time (seconds)"
set yrange [0:]
plot "measurements" with linespoints
