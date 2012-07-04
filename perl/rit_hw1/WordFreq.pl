#!/usr/bin/perl
use strict;
use warnings;

################################################################################
# DESCRIPTION
#
# Script Name:              WordFreq.pl
# Original Creation Date:   Jan 7, 2012
# Original Author:          Jeremy Audet
#
# This script accepts input through STDIN. It then counts up how many times each
# word appears as input. Stats are printed to STDOUT.
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################
my %word_counter    = ();
my $line            = '';
my $word            = '';

################################################################################
# SUBROUTINES
################################################################################

################################################################################
# MAIN
################################################################################

# parse input
while($line = <STDIN>) {
    foreach $word (split(/\s+/, $line)) {
        if(exists($word_counter{$word})) {
            $word_counter{$word}++;
        } else {
            $word_counter{$word} = 1;
        }
    }
}

# print out stats
foreach $word (keys(%word_counter)) {
    print ''. $word_counter{$word} . " <$word>\n";
}

################################################################################
# CODE CHUNKS
################################################################################
