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
use constant TRUE   => 1;
use constant FALSE  => 0;
use constant ARG_CASE_INSENSITIVE  => '-i';

my $arg_case_insensitive = FALSE;
my %word_counter    = ();

################################################################################
# MAIN
################################################################################

# Check all arguments.
foreach my $arg (@ARGV) {
    SWITCH: {
        $arg eq ARG_CASE_INSENSITIVE && do {$arg_case_insensitive = TRUE; last SWITCH;};
        # case default:
        print STDERR "Argument not recognized: \'$arg\'\n";
        exit;
    }
}

# parse input
while(my $line = <STDIN>) {
    # If line consists of whitespace, proceed to next iteration of loop.
    $line =~ /^\s*(.+)\s*$/;
    if(defined($1)) {
        $line = $1;
    } else {
        next;
    }

    if(TRUE == $arg_case_insensitive) {
        $line = lc($line);
        # Or, the following could be written:
        # $line =~ tr/A-Z/a-z/;
        # But such a substitution assumes that the 26-character english
        # alphabet is in use. In constrast, lc() is more flexible; it respects
        # the 'use bytes', 'use locale', and 'use unicode' pragmas.
    }

    # Finally, count up words.
    foreach my $word (split(/\s+/, $line)) {
        if(!exists($word_counter{$word})) {
            $word_counter{$word} = 1;
        } else {
            $word_counter{$word}++;
        }
    }
}

# print out stats
foreach my $word (keys(%word_counter)) {
    print ''. $word_counter{$word} . " <$word>\n";
}

################################################################################
# SUBROUTINES
################################################################################

################################################################################
# CODE CHUNKS
################################################################################
