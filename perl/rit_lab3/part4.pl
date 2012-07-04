#!/usr/bin/perl
use strict;
use warnings;
#use Tk;
#use diagnostics;

#============================================================================-*\
# DESCRIPTION
#
# This program:
# 1) Reads a file from STDIN
# 2) Parses the file, storing individual words in the @fstab_col_n arrays.
# 3) Prints the file to STDOUT.
#============================================================================-*/

#============================================================================-*\
# GLOBAL DECLARATIONS
#

# A sample layout of the fstab file is shown in Figure 2.0. Thanks to wikipedia
# for the example.

# <Figure 2.0>
#
## device name   mount point     fs-type      options                                             dump-freq pass-num
#LABEL=/         /               ext3         defaults                                            1 1
#/dev/hda6       swap            swap         defaults                                            0 0
#none            /dev/pts        devpts       gid=5,mode=620                                      0 0
#none            /proc           proc         defaults                                            0 0
#none            /dev/shm        tmpfs        defaults                                            0 0

# Each @fstab_col_<n> arrays holds a single column of entries from the fstab. 
# So @fstab_col_0 holds an array of <device name>, while @fstab_col_1 holds 
# an array of <mount point>.
#
# @copy_of_file is a copy of the entire fstab file. In writing this 
# program, I am assuming that the fstab file is fairly small (say, under 50 
# lines in all but the most outstanding cases). If I was working with a 
# larger file, I would likely rewrite the program to process the file one 
# line at a time.
#
# Note that @copy_of_file is read directly from STDIN. Therefore, the easiest 
# way to call this program is as follows:
# perl <name_of_this_file.pl> < /path/to/fstab

# The @longest_word_length array holds a series of numbers. Each number 
# describes the length of the longest word in an @fstab_col_<n> column.
#
# Example: if ($longest_word_length[2] == 8), then the longest word in 
# @fstab_col_2 was 8 characters long.
#============================================================================-*/
my @fstab_col_0 = ();
my @fstab_col_1 = ();
my @fstab_col_2 = ();
my @fstab_col_3 = ();
my @fstab_col_4 = ();
my @fstab_col_5 = ();
my @copy_of_file = ();
my @longest_word_length = ();
my @longest_word_location = ();

#============================================================================-*\
# SUBROUTINES
#============================================================================-*/
sub Read_File {
    @copy_of_file = <STDIN>;
}

sub Populate_Fstab_Columns {
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
            # A C equivalent of this would be:
            # switch ($column) {
            #     case 0: {}
            #     case 1: {}
            #     case 2: {}
            #     default:{}
            # };
            SWITCH: {
                $column == 0 && do {push(@fstab_col_0, $word); last SWITCH;};
                $column == 1 && do {push(@fstab_col_1, $word); last SWITCH;};
                $column == 2 && do {push(@fstab_col_2, $word); last SWITCH;};
                $column == 3 && do {push(@fstab_col_3, $word); last SWITCH;};
                $column == 4 && do {push(@fstab_col_4, $word); last SWITCH;};
                $column == 5 && do {push(@fstab_col_5, $word); last SWITCH;};
                print STDERR "oops\n";
            }

            $column++;
        } # foreach $word
    } # foreach $line
}

sub Print_File {
    my $row;

    for($row = 0; $row < scalar(@fstab_col_0); $row++) {
        print "$fstab_col_0[$row]";
        print "$fstab_col_1[$row]";
        print "$fstab_col_2[$row]";
        print "$fstab_col_3[$row]";
        print "$fstab_col_4[$row]";
        print "$fstab_col_5[$row]";
        print "\n";
    }
}

sub Print_File_Stats {
    my $col = 0;

    for($col = 0; $col < 6; $col++) {
        print "COLUMN $col\n";
        SWITCH: {
            $col == 0 && do {print "longest word: $fstab_col_0[$longest_word_location[$col]]\n"; last SWITCH};
            $col == 1 && do {print "longest word: $fstab_col_1[$longest_word_location[$col]]\n"; last SWITCH};
            $col == 2 && do {print "longest word: $fstab_col_2[$longest_word_location[$col]]\n"; last SWITCH};
            $col == 3 && do {print "longest word: $fstab_col_3[$longest_word_location[$col]]\n"; last SWITCH};
            $col == 4 && do {print "longest word: $fstab_col_4[$longest_word_location[$col]]\n"; last SWITCH};
            $col == 5 && do {print "longest word: $fstab_col_5[$longest_word_location[$col]]\n"; last SWITCH};
            print STDERR "oops, again\n";
        }
        print "word length:  $longest_word_length[$col] characters\n";
        print "word index:   $longest_word_location[$col]\n";
        print "\n";
    }
} # sub

# Sub reads the @fstab_col_<n> variables. Sub uses information to do things 
# like finding the length of the longest word.
sub Populate_Stats {
    # What's the length of the longest word?
    # And what's the index of the longest word?
    my $longest_word_size   = 0;
    my $longest_word_index  = 0;
    my $current_word_size   = 0;
    my $i                   = 0;

    # Start by resetting counters. Then cycle through each and every element 
    # of @fstab_col_n. Find the location and length of the longest word. Save 
    # this information.

    # @fstab_col_0
    $longest_word_size  = 0;
    $longest_word_index = 0;
    for($i = 0; $i < scalar(@fstab_col_0); $i++) {
        $current_word_size = length($fstab_col_0[$i]);
        if($current_word_size > $longest_word_size) {
            $longest_word_size  = $current_word_size;
            $longest_word_index = $i;
        }
    }
    $longest_word_length[0]   = $longest_word_size;
    $longest_word_location[0] = $longest_word_index;

    # @fstab_col_1
    $longest_word_size  = 0;
    $longest_word_index = 0;
    for($i = 0; $i < scalar(@fstab_col_1); $i++) {
        $current_word_size = length($fstab_col_1[$i]);
        if($current_word_size > $longest_word_size) {
            $longest_word_size  = $current_word_size;
            $longest_word_index = $i;
        }
    }
    $longest_word_length[1]   = $longest_word_size;
    $longest_word_location[1] = $longest_word_index;

    # @fstab_col_2
    $longest_word_size  = 0;
    $longest_word_index = 0;
    for($i = 0; $i < scalar(@fstab_col_2); $i++) {
        $current_word_size = length($fstab_col_2[$i]);
        if($current_word_size > $longest_word_size) {
            $longest_word_size  = $current_word_size;
            $longest_word_index = $i;
        }
    }
    $longest_word_length[2]   = $longest_word_size;
    $longest_word_location[2] = $longest_word_index;

    # @fstab_col_3
    $longest_word_size  = 0;
    $longest_word_index = 0;
    for($i = 0; $i < scalar(@fstab_col_3); $i++) {
        $current_word_size = length($fstab_col_3[$i]);
        if($current_word_size > $longest_word_size) {
            $longest_word_size  = $current_word_size;
            $longest_word_index = $i;
        }
    }
    $longest_word_length[3]   = $longest_word_size;
    $longest_word_location[3] = $longest_word_index;

    # @fstab_col_4
    $longest_word_size  = 0;
    $longest_word_index = 0;
    for($i = 0; $i < scalar(@fstab_col_4); $i++) {
        $current_word_size = length($fstab_col_4[$i]);
        if($current_word_size > $longest_word_size) {
            $longest_word_size  = $current_word_size;
            $longest_word_index = $i;
        }
    }
    $longest_word_length[4]   = $longest_word_size;
    $longest_word_location[4] = $longest_word_index;

    # @fstab_col_5
    $longest_word_size  = 0;
    $longest_word_index = 0;
    for($i = 0; $i < scalar(@fstab_col_5); $i++) {
        $current_word_size = length($fstab_col_5[$i]);
        if($current_word_size > $longest_word_size) {
            $longest_word_size  = $current_word_size;
            $longest_word_index = $i;
        }
    }
    $longest_word_length[5]   = $longest_word_size;
    $longest_word_location[5] = $longest_word_index;
}

#============================================================================-*\
# Main
#============================================================================-*/
Read_File();
Populate_Fstab_Columns();
Populate_Stats();

print "/*-==================================-*\\\n";
print "Original File\n";
print "\\*-==================================-*/\n";
Print_File();
print "\n";

print "/*-==================================-*\\\n";
print "File Stats\n";
print "\\*-==================================-*/\n";
Print_File_Stats();
print "\n";
print "Done!\n";
