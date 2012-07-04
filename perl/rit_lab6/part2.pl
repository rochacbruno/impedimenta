#!/usr/bin/perl
use strict;
use warnings;
# use diagnostics;
use Readonly;

################################################################################
# DESCRIPTION
#
# Script Name:              part1.pl
# Original Creation Date:   Feb 5th, 2012
# Original Author:          Jeremy Audet
#
# This program is my shot at perl lab 6, part 2.
# 
# Sample usage:
# part1.pl [input_file, ...]
#
# Format of input_file:
# <name> <age> <gpa> <major>
#
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################

Readonly::Scalar my $NUM_COLS           => 4;
my @students                            = ();           # array that holds refs pointing to anonymous %student hashes
#my $students                            = \@students;   # ref that points to the array @students

################################################################################
# MAIN
################################################################################

foreach my $filename (@ARGV) {
    &Read_File($filename, \@students);
}
#&Print_Student_Records(\@students);
&Menu_Loop();

################################################################################
# SUBROUTINES
################################################################################

# Menu_Loop
# Sort_Up
# Sort_Down
# Print_Student_Records
# Read_File

########################################
# SUB
#
# No arguments.
# Infinite loop.
# Calls other subs as needed.
sub Menu_Loop {
    while(1) {
        my $input = '';

        print "Commands:\n";
        print "1 'sort up'   (sort records by name, z-a)\n";
        print "2 'sort down' (sort records by name, a-z)\n";
        print "3 'quit'\n";
        print "choice> ";
        chomp($input = <STDIN>);
        print "\n";

        SWITCH: {
            # case 'sort up' OR 1
            (('sort up' eq $input) or ('1' eq $input)) && do {
                &Sort_Up(\@students);
                &Print_Student_Records(\@students);
                last SWITCH;
            };

            # case 'sort down' OR 2
            (('sort down' eq $input) or ('2' eq $input)) && do {
                &Sort_Down(\@students);
                &Print_Student_Records(\@students);
                last SWITCH;
            };

            # case 'quit' OR 3
            (('quit' eq $input) or ('3' eq $input))&& do {
                exit;
            };

            # case default
            print "Input not recognized.\n";
            print "\n";
        };
    }# while(1)
}# sub

########################################
# SUB
#
# $_[0]
#   input
#   Reference to array. Array elements are refs, each of which points to a
#   single "student record" hash.
#
# Sorts the given student records 'upwards', from z-a, according to student
# name. Case is ignored.
sub Sort_Up {
    my $array_ref   = shift;
    my $i           = 0;
    my $j           = 0;

    # This is a bubble sort.
    # The bubble sort must pass over the entire array (array_size - 1) times.
    # Each time a pass is completed, the last unsorted element is now sorted correctly.
    for($i = 0; $i < scalar(@$array_ref) - 1; $i++) {
        for($j = 0; $j < scalar(@$array_ref) - 1 - $i; $j++) {
            # -1 == (a cmp b)
            #  0 == (a cmp a)
            #  1 == (b cmp a)
            if(1 == (lc($array_ref->[$j]->{name}) cmp lc($array_ref->[$j + 1]->{name}))) {
                ($array_ref->[$j], $array_ref->[$j + 1]) = ($array_ref->[$j + 1], $array_ref->[$j]);
            }
        }# for
    }# for
}# sub

########################################
# SUB
#
# $_[0]
#   input
#   Reference to array. Array contains a series of refs, each of which points to
#   a single "student record" hash.
#
# Sorts the given student records 'downwards', from a-z, according to student
# name. Case is ignored.
sub Sort_Down {
    my $array_ref   = shift;
    my $i           = 0;
    my $j           = 0;

    # This is a bubble sort.
    # The bubble sort must pass over the given array (scalar(@array) - 2) times.
    # At the end of each pass, the last element _must_ be sorted correctly.
    for($i = 0; $i < scalar(@$array_ref) - 1; $i++) {
        for($j = 0; $j < scalar(@$array_ref) - 1 - $i; $j++) {
            # -1 == (a cmp b)
            #  0 == (a cmp a)
            #  1 == (b cmp a)
            if(-1 == (lc($array_ref->[$j]->{name}) cmp lc($array_ref->[$j + 1]->{name}))) {
                ($array_ref->[$j], $array_ref->[$j + 1]) = ($array_ref->[$j + 1], $array_ref->[$j]);
            }
        }# for
    }# for
}# sub

########################################
# SUB
#
# $_[0]
#   input
#   Reference to array. Array contains a series of refs, each of which points to
#   a single "student record" hash.
sub Print_Student_Records {
    my $array_ref = shift;

    # Print out a copy of each student record.
    foreach my $student_record (@$array_ref) {
        # (20 chars          )(4 )(56 chars                                              )
        # name                 => value
        # age                  => value
        # gpa                  => value
        # major                => value

        # %d decimal
        # %s string
        # %f float, fixed-point notation
        printf("%-20s => %-56s\n",  'name', $$student_record{name});
        printf("%-20s => %-56d\n",  'age',  $$student_record{age});
        printf("%-20s => %-56.1f\n",'gpa',  $$student_record{gpa});
        printf("%-20s => %-56s\n",  'major',$$student_record{major});
        print "\n";
    }
}

########################################
# SUB
#
# $_[0]
#   input
#   name of file to read
# $_[1]
#   output
#   array onto which an anonymous hash (containing a single student record) will be pushed
sub Read_File {
    my $filename    = shift;
    my $array_ref   = shift;
    my @split_line  = ();

    open(INFILE, $filename) or die("Cannot open file $filename: $!\n");
    while(<INFILE>) {
        chomp;
        @split_line = split;

        # check all error conditions before creating a new student hash
        if(4 != scalar(@split_line)) {
            print STDERR "Incorrect number of columns in input file $filename\n";
            print STDERR "Needed: $NUM_COLS. Have: " . scalar(@split_line) . "\n";
            print STDERR "Input: @split_line\n";
        } elsif($split_line[1] !~ /^\d+$/) {
            print STDERR "Second column of input (age) must be a number. Input given: $split_line[1]\n";
        } elsif($split_line[2] !~ /^\d+(\.\d+)?$/) {
            print STDERR "Third column of input (gpa) must be a number. Input given: $split_line[2]\n";
        } else {
            # push an anonymous hash onto an array
            push(
                @$array_ref,
                +{
                    name    => $split_line[0],
                    age     => $split_line[1],
                    gpa     => $split_line[2],
                    major   => $split_line[3],
                }
            );# push
        }# else
    }# while(<INFILE>)
    close(INFILE);
}

################################################################################
# TEMPLATES
################################################################################

# # {} can be used to create either an anonymous hash or a code block.
# # +{} is used to explicitly create an anonymous hash.
# # {;} is used to explicitly create a code block

# my $ref_to_gilligan_info = {
#     name => 'Gilligan',
#     hat => 'White',
#     shirt => 'Red',
#     position => 'First Mate',
# };
# my $ref_to_skipper_info = {
#     name => 'Skipper',
#     hat => 'Black',
#     shirt => 'Blue',
#     position => 'Captain',
# };
# my @crew = ($ref_to_gilligan_info, $ref_to_skipper_info);
