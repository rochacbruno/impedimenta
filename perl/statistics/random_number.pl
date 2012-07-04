#!/usr/bin/perl
use strict;
use warnings;

# Generate a random number, somewhere in the range of $min to $max.

die "Usage: random_number.pl <min> <max>\n" unless (2 == @ARGV);
my $min = shift;
my $max = shift;
die "<min> must be an integer number. <min> is $min.\n" unless $min =~ m/^\d+$/;
die "<max> must be an integer number. <max> is $max.\n" unless $max =~ m/^\d+$/;

my $number = int(rand($max - $min));
print '' . ($number + $min) . "\n";
