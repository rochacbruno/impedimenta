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
my $name                                = "";
my $gpa                                 = "";

#======================================
# Main Program
#======================================
print "Enter your name.\n";
print "> ";
chomp($name = <STDIN>);

print "Enter your GPA.\n";
print "> ";
chomp($gpa = <STDIN>);

print "\n";
print "$name, a GPA of $gpa is ";
if(4.0 <= $gpa) {
    print "outstanding!\n";
} elsif(3.0 <= $gpa) {
    print "great.\n";
} elsif(2.0 <= $gpa) {
    print "acceptable.\n";
} elsif(1.0 <= $gpa) {
    print "questionable.\n";
} elsif(0.0 <= $gpa) {
    print "horrid.\n";
} else {
    print "incomprehensible.\n";
}
