#!/usr/bin/perl
use strict;
use warnings;
use Readonly;
# use diagnostics;

################################################################################
# DESCRIPTION
#
# Script Name:              part1.pl
# Original Creation Date:   Feb 5th, 2012
# Original Author:          Jeremy Audet
#
# This program is my shot at perl lab 6, part 3. This program reads in a set
# of 'student records', then backgrounds itself. Whenever the signals
# SIGHUP    (print out student names whose GPAs are above what's specified in $MIN_GPA_FILE)
# SIGUSR1   (print out student records, 
# SIGUSR2
# are received, the appropriate action is taken. Output is printed to the
# shell which launched the program. If that shell is closed, this program is
# also killed, as there is nothing to send output to (and this program isn't
# intended to properly daemonize and log output).
# 
# This program ignores all arguments passed to it. It relies upon the following
# files being present:
# $RECORDS_FILE
# $MIN_GPA_FILE
#
# The file $MIN_GPA_FILE simply contains a single number, like 0 or 3.4.
# The file $RECORDS_FILE contains a path to a file. Example contents:
# /home/foo/stu_records.txt
# The specified file holds student records. Each line is in the format:
# <name> <age> <gpa> <major>
# For example:
# joe 22 2.5 business
#
################################################################################

# TODO list
#

################################################################################
# GLOBAL DECLARATIONS
################################################################################

# How many columns of data are in each input file containing student records?
# Consequently, how many values will be in each student record hash?
Readonly::Scalar my $NUM_COLS           => 4;
# Currently, only a single file containing student records can be read in. Where
# is this "student records file" to be found? A path (in future versions, a
# series of paths?) specifying where student records can be found is in
# $RECORDS_FILE.
# Example contents of $RECORDS_FILE:
# /home/ichimonji10/Documents/stu_records.txt
Readonly::Scalar my $RECORDS_FILE       => '/tmp/filename.txt';
# A minimum GPA must be known whn handling SIGHUP. The minimum GPA to be used is
# specified in $MIN_GPA_FILE.
# Example contents of $MIN_GPA_FILE:
# 3.4
Readonly::Scalar my $MIN_GPA_FILE       => '/tmp/minimum.txt';

# Holds refs pointing to anonymous %student record hashes.
my @students                            = ();
# Is an interrupt currently being handled?
my $interrupt                           = 0;
# What is the minimum GPA to use when handling SIGHUP?
my $min_gpa                             = 0.0;

################################################################################
# MAIN
################################################################################

# A properly daemon-ized process cannot write to STDOUT. For the purposes of 
# this assignment, a better approach is to just fork the current process and 
# kill the parent.
exit unless (0 == fork());
print "New child: $$\n";

# Populate data structures.
{;
    # $filename is only used here. Use scoping to enforce such.
    my $filename = '';

    # Figure out where student records are, then read in student records.
    open(FILE, $RECORDS_FILE) or die("Cannot open $RECORDS_FILE: $!\n");
    chomp($filename = <FILE>);
    close(FILE) or die("Cannot close $RECORDS_FILE: $!\n");
    &Get_Student_Records($filename, \@students);
}
$min_gpa = &Get_Min_GPA();
# Done populating data structures.

# Don't set any interrupt handlers until all the data structures this program
# uses have been populated.
&Set_Interrupt_Handlers(\$interrupt, \@students, $min_gpa);

# Interrupt handlers provide all further program functionality.
while(1) {
    sleep(100);
}

################################################################################
# SUBROUTINES
################################################################################

# Print_Student_Records
# Get_Student_Records
# Get_Min_GPA
#
# Sort_Up
# Sort_Down
#
# Handle_HUP
# Handle_USR1
# Handle_USR2

########################################
# Subroutine
#
# $_[0]
#   ref to scalar. Tells whether another interrupt is currently in process.
# $_[1]
#   ref to array. Array contains refs pointing to student records.
# $_[2]
#   scalar. Tells the minimum GPA to use when calling Handle_HUP.
########################################

sub Set_Interrupt_Handlers {
    my $interrupt_ref   = shift;
    my $records_ref     = shift;
    my $min_gpa         = shift;

    $SIG{'HUP' } = sub {
        if($$interrupt_ref) {
            warn "Cannot handle interrupt SIGHUP: interrupt already in progress.\n";
        } else {
            $$interrupt_ref = 1;
            &Handle_HUP($min_gpa, $records_ref);
            $$interrupt_ref = 0;
        }
    };

    $SIG{'USR1'} = sub {
        if($$interrupt_ref) {
            warn "Cannot handle interrupt SIGUSR1: interrupt already in progress.\n";
        } else {
            $$interrupt_ref = 1;
            &Handle_USR1($records_ref);
            $$interrupt_ref = 0;
        }
    };

    $SIG{'USR2'} = sub {
        if($$interrupt_ref) {
            warn "Cannot handle interrupt SIGUSR2: interrupt already in progress.\n";
        } else {
            $$interrupt_ref = 1;
            &Handle_USR2($records_ref);
            $$interrupt_ref = 0;
        }
    };
}

########################################
# Subroutine
#
# Ignores all arguments.
# Uses global variable $MIN_GPA_FILE.
# Returns a minimum GPA.
# If GPA cannot be found, or if GPA is incorrectly formatted, kills program.
########################################

sub Get_Min_GPA {
    my $gpa = 0.0;

    # Figure out what the minimum GPA is.
    open(FILE, $MIN_GPA_FILE) or die("Cannot open $MIN_GPA_FILE: $!\n");
    chomp($gpa = <FILE>);
    close(FILE) or die("Cannot close $MIN_GPA_FILE: $!\n");

    # Is the minimum GPA valid?
    if($min_gpa !~ m/^\d+(\.\d+)?$/) {
        warn "GPA of \'$gpa\' from $MIN_GPA_FILE is not valid. Exiting.\n";
        exit;
    }

    return $gpa;
}

########################################
# Subroutine
#
# $_[0]
#   input
#   Reference to array. Array elements are refs, each of which points to a
#   single "student record" hash.
#
# Sorts the given student records 'upwards', from z-a, according to student
# name. Case is ignored.
########################################

sub Sort_Up {
    my $array_ref   = shift;
    my $i           = 0;
    my $j           = 0;

    # This is a bubble sort.
    # The bubble sort must pass over the given array (scalar(@array) - 2) times.
    # After each pass, the last unsorted element is now sorted correctly.
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
# Subroutine
#
# $_[0]
#   input
#   Reference to array. Array contains a series of refs, each of which points to
#   a single "student record" hash.
#
# Sorts the given student records 'downwards', from a-z, according to student
# name. Case is ignored.
########################################

sub Sort_Down {
    my $array_ref   = shift;
    my $i           = 0;
    my $j           = 0;

    # This is a bubble sort.
    # The bubble sort must pass over the given array (scalar(@array) - 2) times.
    # After each pass, the last unsorted element is now sorted correctly.
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
# Subroutine
#
# $_[0]
#   input
#   Reference to array. Array contains a series of refs, each of which points to
#   a single "student record" hash.
########################################

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
# Subroutine
#
# $_[0]
#   input
#   name of file to read
# $_[1]
#   output
#   array onto which an anonymous hash (containing a single student record) will be pushed
########################################

sub Get_Student_Records {
    my $filename    = shift;
    my $array_ref   = shift;
    my @split_line  = ();

    open(INFILE, $filename) or die("Cannot open file $filename: $!\n");
    while(<INFILE>) {
        chomp;
        @split_line = split;

        # Check the line read in before creating a student record hash.
        # If line is malformed in any way, skip this line.
        if(4 != scalar(@split_line)) {
            warn "Incorrect number of columns in input file $filename\n";
            warn "Needed: $NUM_COLS. Have: " . scalar(@split_line) . "\n";
            warn "Input: @split_line\n";
        } elsif($split_line[1] !~ /^\d+$/) {
            warn "Second column of input (age) must be a number. Input given: $split_line[1]\n";
        } elsif($split_line[2] !~ /^\d+(\.\d+)?$/) {
            warn "Third column of input (gpa) must be a number. Input given: $split_line[2]\n";
        } else {
            # Create an anonymous hash. Push a ref to this hash onto an array.
            push(
                @$array_ref,
                +{
                    name    => $split_line[0],
                    age     => $split_line[1],
                    gpa     => $split_line[2],
                    major   => $split_line[3],
                }
            );
        }# else
    }# while(<INFILE>)
    close(INFILE);
}# sub

########################################
# Subroutine
#
# $_[0]
#   minimum GPA to use when printing out student names
# $_[1]
#   ref to array. Array contains refs pointing to student records.
########################################

sub Handle_HUP {
    my $min_gpa = shift;
    my $students_ref = shift;

    print "SIGHUP handler starting.\n";
    my @student_subset = grep {$_->{gpa} >= $min_gpa} @$students_ref;
    foreach my $record (@student_subset) {
        print "$record->{name}\n";
    }
    print "SIGHUP handler done.\n";
}

########################################
# Subroutine
#
# $_[0]
#   ref to array. Array contains refs pointing to student records.
########################################

sub Handle_USR1 {
    my $students_ref = shift;

    print "SIGUSR1 handler starting.\n";
    &Sort_Up($students_ref);
    &Print_Student_Records($students_ref);
    print "SIGUSR1 handler done.\n";
}

########################################
# Subroutine
#
# $_[0]
#   ref to array. Array contains refs pointing to student records.
########################################

sub Handle_USR2 {
    my $students_ref = shift;

    print "SIGUSR2 handler starting.\n";
    &Sort_Down($students_ref);
    &Print_Student_Records($students_ref);
    print "SIGUSR2 handler done.\n";
}

################################################################################
# JUNKYARD
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

#use Proc::Daemon;
#
# This module takes care of all the messy details of creating a daemon. Init()
# kills the parent, and only a grand-child lives on. As a result, only the
# child runs code after this point; no special clean-up is required.
#Proc::Daemon::Init();
