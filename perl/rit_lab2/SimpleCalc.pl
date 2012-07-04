#!/usr/bin/perl
use warnings;
use strict;

#============================================================================-*\
# Description
#============================================================================-*/
#
# This program is an extremely simple emulator of a point of sale terminal.
# Sample run:
#
# Enter the number of items bought: <input>
# Enter the price of one item: <input>
# Tax rate:                 <output>
# Total before tax:         <output>
# Total after tax:          <output>

#============================================================================-*\
# Initializations
#============================================================================-*/
use constant TAX_RATE => 0.08;

my $num_of_items = 0;
my $price_per_item = 0;

#============================================================================-*\
# Main
#============================================================================-*/
#
# Examples of regular expressions: http://www.somacon.com/p127.php
# In a regex comparison, the regex MUST be on the right side of a comparison.
# e.g. ($num_of_items !~ m/^\d+$/   ) is OK
#      (m/^\d+$/    !~ $num_of_items) is WRONG

# Read in the number of items bought. Validate input.
print("Enter the number of items bought: ");
chomp($num_of_items = <STDIN>);
while($num_of_items !~ m/^\d+$/) {
    # m/        match
    # ^         beginning of line
    # \d+       one or more digits
    # $         end of line
    print("Whoops, that's not a number! Try again.\n");
    print("Enter the number of items bought: ");
    chomp($num_of_items = <STDIN>);
}

# Read in the price for each item. Validate input.
print("Enter the price of one item: ");
chomp($price_per_item = <STDIN>);
while($price_per_item !~ m/\d+$/) {
    # m/        match
    # ^         beginning of line
    # \d+       one or more digits
    # $         end of line
    print("Whoops, that's not a number! Try again.\n");
    print("Enter the price of one item: ");
    chomp($price_per_item = <STDIN>);
}

# Use sprintf() to format input.
# see: http://perldoc.perl.org/functions/sprintf.html
print "Tax rate:         " . sprintf("%.2f", TAX_RATE * 100)                                 . "%\n";
print "Total before tax: " . sprintf("%.2f", ($num_of_items * $price_per_item))                  . "\n";
print "Total after tax:  " . sprintf("%.2f", ($num_of_items * $price_per_item * (1 + TAX_RATE))) . "\n";

#============================================================================-*\
# Subroutines
#============================================================================-*/
