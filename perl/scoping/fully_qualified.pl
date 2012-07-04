#!/usr/bin/perl
use strict;
use warnings;

########################################
# DESCRIPTION
########################################
# Script Name:      fully_qualified.pl
# Creation Date:    02/18/2012
# Author(s):        Jeremy Audet

########################################
# MAIN
########################################

# fully-qualify the assignment
$main::robert = "the boss";
print "robert is $robert\n";

# fully qualify the interpolation
$robert = "the boss";
print "robert is $main::robert\n";

# fully qualify both assignment and interpolation
$main::robert = "the boss";
print "robert is $main::robert\n";
