#!/usr/bin/perl
use strict;
use warnings;
use Readonly;

########################################
# Script Name:      part3.pl
# Creation Date:    02/23/2012
# Author(s):        Jeremy Audet
#
# This is my attempt at perl lab 8, part 3. This script reads in a series of
# integer prices then prints out some stats about them. Specifically, it prints
# out an average price, a subtotal, and a total after tax is applied.
########################################

Readonly::Scalar my $TAX_RATE => 0.08;

my $total_price = 0;
my $num_prices  = 0;

print "Stop by entering \'q\'.\n";
while(1) {
    print "Item Price: ";
    my $input = <STDIN>;

    # verify input
    chomp $input;
    $input =~ s/^\s+//;
    $input =~ s/\s+$//;
    last if('q' eq $input);
    if($input !~ /^\d+$/) {
        print "Input must be an integer number.\n";
        next;
    }

    $total_price += $input;
    $num_prices++;
}

print ''.('-' x 20)."\n";
print "Average:  ".($total_price / $num_prices)."\n";
print "Subtotal: $total_price\n";
print "Tax:      $TAX_RATE\n";
print "TOTAL:    ".($total_price + ($total_price * $TAX_RATE))."\n";
