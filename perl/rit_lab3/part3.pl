#!/usr/bin/perl
use strict;
use warnings;
#use Tk;
#use diagnostics;

#============================================================================-*\
# Description
#============================================================================-*/
# This program:
# 1) Reads a file from STDIN
# 2) Parses the file, storing individual words in the @fstab_col_n arrays.
# 3) Prints the file to STDOUT.

#============================================================================-*\
# Global Declarations
#============================================================================-*/
my @fstab_col_0 = ();
my @fstab_col_1 = ();
my @fstab_col_2 = ();
my @fstab_col_3 = ();
my @fstab_col_4 = ();
my @fstab_col_5 = ();
my @copy_of_file = <STDIN>; # Important!

#============================================================================-*\
# Subroutines
#============================================================================-*/
sub Read_File {
    my $line = "";
    my $word = "";
    my $column = 0;
    my @split_line = ();

    # start reading through @copy_of_file
    foreach $line (@copy_of_file) {
        # Each line should be split up into individual "words".
        # In this case, each word is delimited by one or more whitespace characters.
        @split_line = split(/\s+/, $line);

        # There may be up to six words on each line.
        $column = 0;
        foreach $word (@split_line) {
            SWITCH: { # switch ($column) {case 0: {}};
                $column == 0 && do {push(@fstab_col_0, $word); last SWITCH;};
                $column == 1 && do {push(@fstab_col_1, $word); last SWITCH;};
                $column == 2 && do {push(@fstab_col_2, $word); last SWITCH;};
                $column == 3 && do {push(@fstab_col_3, $word); last SWITCH;};
                $column == 4 && do {push(@fstab_col_4, $word); last SWITCH;};
                $column == 5 && do {push(@fstab_col_5, $word); last SWITCH;};
                print STDERR "oops\n";
            }

            $column++;
        }
    }
}

sub Print_File {
    my $row;

    for($row = 0; $row < scalar(@fstab_col_0); $row++) {
        print "<$fstab_col_0[$row]>";
        print "<$fstab_col_1[$row]>";
        print "<$fstab_col_2[$row]>";
        print "<$fstab_col_3[$row]>";
        print "<$fstab_col_4[$row]>";
        print "<$fstab_col_5[$row]>";
        print "\n";
    }
}

sub Print_Columns {
    print "\@fstab_col_0\n";
    print "@fstab_col_0\n";
    print "--------------------\n";
    print "\@fstab_col_1\n";
    print "@fstab_col_1\n";
    print "--------------------\n";
    print "\@fstab_col_2\n";
    print "@fstab_col_2\n";
    print "--------------------\n";
    print "\@fstab_col_3\n";
    print "@fstab_col_3\n";
    print "--------------------\n";
    print "\@fstab_col_4\n";
    print "@fstab_col_4\n";
    print "--------------------\n";
    print "\@fstab_col_5\n";
    print "@fstab_col_5\n";
}

#============================================================================-*\
# Main
#============================================================================-*/
Read_File();
#Print_File();
Print_Columns();
