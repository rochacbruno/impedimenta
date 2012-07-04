#! /usr/bin/perl -w
# Jeremy Audet
# prog2 -l -- a simple-minded program that tells a joke.
# Here's a quick rundown of the steps.
#
# ask user if they want to hear a joke.

$reply = '';

print "Would you like to hear a joke?\n";
chomp($reply = <STDIN>);

