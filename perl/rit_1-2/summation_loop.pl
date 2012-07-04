#!/usr/bin/perl
use strict;
use warnings;
#===========================================================================--\
# Author(s):        Jeremy Audet
# First Created:    11/30/2011
# License:          Creative Commons CC0 1.0
#                   http://creativecommons.org/publicdomain/zero/1.0/
#                   The CC0 license places the associated work in the public domain.
#
# This file was created as part of a classroom assignment. It simply adds 
# together a set of consecutive values and displays their sum.
#===========================================================================--/

#======================================
# Declarations
#======================================
my $i   = 0;
my $sum = 0;

#======================================
# Main Program
#======================================
$i      = 0;
$sum    = 0;
while($i < 10) {
    $sum += $i;

    $i++;
}

print "The sum of 1 through 10 is: $sum.\n";
