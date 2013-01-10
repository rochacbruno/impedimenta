#!/usr/bin/perl
use strict;
use warnings;

#############################################################################-*\
#
# Author(s):
# Jeremy Audet
#
# First Created: 10/24/2011
# License: Creative Commons BY-SA        http://creativecommons.org/licenses/by-sa/3.0/
#
#############################################################################-*/

my $input;

print "Type something, press 'enter', and it will be echoed back.\n";
print "Press CTRL-D or CTRL-C to quit.\n";

$input = <STDIN>;
print "$input";
