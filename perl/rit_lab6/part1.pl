#!/usr/bin/perl
use strict;
use warnings;
# use diagnostics;
use Readonly;
use Data::Dumper;

################################################################################
# DESCRIPTION
#
# Script Name:              part1.pl
# Original Creation Date:   Feb 5th, 2012
# Original Author:          Jeremy Audet
#
# This program is my shot at perl lab 6, part 1.
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
my $students                            = \@students;   # ref that points to the array @students

################################################################################
# MAIN
################################################################################
foreach my $filename (@ARGV) {
    &Read_File($filename, \@students);
}
&Print_Student_Records(\@students);

print Dumper($students);
#print Dumper(\@students);

################################################################################
# SUBROUTINES
################################################################################

########################################
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

# $students[0] = +{
#     name                    => 'name_a',
#     age                     => 0,
#     gpa                     => 0.0,
#     major                   => 'major_a',
# };
# $students[1] = +{
#     name                    => 'name_b',
#     age                     => 1,
#     gpa                     => 1.1,
#     major                   => 'major_b',
# };
# print "\@students: @students\n";

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
# 
# You can now avoid the temporary variables and insert the values directly into the top-level list:
# 
# my @crew = (
#     {
#         name => 'Gilligan',
#         hat => 'White',
#         shirt => 'Red',
#         position => 'First Mate',
#     },
#     {
#         name => 'Skipper',
#         hat => 'Black',
#         shirt => 'Blue',
#         position => 'Captain',
#     },
# );
