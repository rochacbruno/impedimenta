#!/usr/bin/perl
use warnings;
use strict;
#use diagnostics;

#============================================================================-*\
# Description
#============================================================================-*/
#
# This program exists to test various methods of reading input.
# Specifically, I'm interested in how fill an array from STDIN and files.

#============================================================================-*\
# Declarations
#============================================================================-*/
my @input        = ("");
my $line         = "";
my $num_of_lines = 0;
my $num_of_words = 0;
my $num_of_chars = 0;

#============================================================================-*\
# Main
#============================================================================-*/

# Get input from user.
print("Enter some text. To end input, press CTRL-D (control and d).\n");
@input = <STDIN>;

# Analyze input.
$num_of_lines = scalar(@input);
foreach $line (@input) {
    $num_of_chars += scalar(length($line       ));
    $num_of_words += scalar(split (/\s+/, $line));
    # \s        whitespace
    # +         one or more times
}

# Display info about input (input will be chomp()'ed as part of this process).
print("$num_of_lines lines\n");
print("$num_of_words words\n");
print("$num_of_chars characters (including newlines)\n");
print("Your input is as follows (all input surrounded by <>).\n\n");
foreach $line (@input) {
    chomp($line);
    print("<$line>\n");
}

#============================================================================-*\
# Subroutines
#============================================================================-*/
