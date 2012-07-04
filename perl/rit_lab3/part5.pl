#!/usr/bin/perl
use strict;
use warnings;
#use diagnostics;

#============================================================================-*\
# DESCRIPTION
#
# Read in a file, line-by-line. Store this file in a 2d array. Mangle this 2d
# array so that columns of words are lined up (words are delimited by
# whitespace). Print out the newly-formatted file.
#
# The # character is treated as a comment. Anything following the first
# occurence of the # character will not be formatted. For example, let's say
# this line is read in:
# foo b#r
#
# The above will be split into this array:
# foo, b, #r
#
# And let's say this line is read in:
# 1#2#3
#
# The above will be split into this array:
# 1, #2#3
#
# This program will output the following:
# foo b #r
# 1   #2#3
#============================================================================-*/

#============================================================================-*\
# GLOBAL DECLARATIONS
#============================================================================-*/
my $line        = '';
my @line_refs   = ();
my @col_widths  = ();

#============================================================================-*\
# SUBROUTINES
#============================================================================-*/

#============================================================================-*\
# MAIN
#============================================================================-*/

# Read in a file, one line at a time. Split each line up into individual words.
while(defined($line = <STDIN>)) {
    chomp($line);
    if($line =~ /#/) {
        # If comment exists, temporarily remove the comment from the line.
        # Then split the line into component words, and append the comment to
        # the end of the line as a single word.
        $line =~ s/(.*?)(#.*)/$1/;
        push(@line_refs, [split(/\s+/, $line), $2]);
    } else {
        push(@line_refs, [split(/\s+/, $line)    ]);
    }
}

# Find the length of the longest word in each column.
foreach my $line_ref (@line_refs) {
    my $column = 0;

    # Start examining all of the words in a single line of text. The first word
    # in a line belongs to the 0th column, the second word belongs to the 1st
    # column, and so on.
    foreach my $word (@$line_ref) {
        if(!defined($col_widths[$column])) {
            $col_widths[$column] = 0;
        }

        if($word =~ /^#/) {
            # If $word is a comment, do not examine its length.
            # Its length will not be needed when formatting output.
        } elsif(length($word) > $col_widths[$column]) {
            $col_widths[$column] = length($word);
        }

        $column++;
    }
    # Done examining all of the words in the current line of text.
}

# Modify each word so it's equal in length to the longest word in that column.
foreach my $line_ref (@line_refs) {
    my $column = 0;
    foreach my $word (@$line_ref) {
        # Only modify word if word is not a comment.
        if($word !~ /^#/) {
            $word = $word . (' ' x ($col_widths[$column] - length($word)));
            $column++;
        }
    }
}

# Then print out the final file.
foreach my $line_ref (@line_refs) {
    foreach my $word (@$line_ref) {
        print "$word ";
    }
    print "\n";
}

# Stats!
# for(my $i = 0; $i <  scalar(@col_widths); $i++) {
#     print "col $i width: $col_widths[$i]\n";
# }
