#!/usr/bin/perl
use strict;
use warnings;
use feature 'switch';

# TESTING_ONLY
#use Readonly;

# DIAGNOSTIC
#use Data::Dumper;
#use diagnostics;

################################################################################
# DESCRIPTION
################################################################################
# Script Name:              resources.pl
# Original Creation Date:   Feb 11, 2012
# Original Author:          Jeremy Audet

# Usage:
# resources.pl
#
# All arguments will be ignored.

# This program read in output from the 'top' program. The user can then ask the
# output to be reformatted in one of several ways. Specifically, the user can
# type in the following commands:
# sort by <column_name>
# sort increasing
# sort decreasing
# quit

# <column_name> may have a value of:
# PID
# USER
# CPU
# MEM
# COMMAND

# Commands from the user may have excess whitespace before and after each word.
# This is tolerated.

# Pipe output of commands to 'more'.

# Data structures look like this:
# @rows_ptrs
# %one_row_hash         (anonymous)

# Interesting tags in this file:
# DIAGNOSTIC
# TESTING_ONLY
# PRODUCTION

################################################################################
# GLOBAL DECLARATIONS
################################################################################

# TESTING_ONLY
# Readonly::Scalar my $TOP_CMD            => 'top -bn1 |';
 #Readonly::Scalar my $MORE_CMD           => '| more';

# PRODUCTION
my $TOP_CMD                             = 'top -bn1 |';
my $MORE_CMD                            = '| more';

################################################################################
# MAIN
################################################################################

# The code block prevents 'main' variables from being seen globally.
{
    # This array contains refs. Each ref points to a single hash. Each hash holds info
    # corresponding to a single row of 'top' output.
    my @hashes      = ();
    my $sort_col    = 'pid';
    my $user_input  = '';

    # fetch 'top' output, parse it, and populate a series of hashes with this data
    &Read_Parse_Top(\@hashes);

    # DIAGNOSTIC
    #print Dumper(\@hashes);

    # This program uses a flat menu -- no sub-menus.
    while(1) {
        # Start by grabbing input from th user.
        print "Menu Choices:\n";
        print "* sort by <column_name>\n";
        print "* sort increasing\n";
        print "* sort decreasing\n";
        print "* quit\n";
        print "<column_name> may be: pid, user, cpu, mem, command\n";
        print "Choice: ";
        $user_input = <STDIN>;
        chomp($user_input);
        $user_input =~ s/^\s+//;

        # Input has been gotten from the user. Now what? Be careful about
        # whitespace in the user's input.
        given($user_input) {
            when(m/^sort\s+increasing/i) {&Sort_Increasing($sort_col, \@hashes); &Print_Data(\@hashes);}
            when(m/^sort\s+decreasing/i) {&Sort_Decreasing($sort_col, \@hashes); &Print_Data(\@hashes);}
            when(m/^sort\s+by\s+(\S+)/i) {
                given($1) {
                    when(m/^pid$/i)     {$sort_col = 'pid';}
                    when(m/^user$/i)    {$sort_col = 'user';}
                    when(m/^cpu$/i)     {$sort_col = 'cpu';}
                    when(m/^mem$/i)     {$sort_col = 'mem';}
                    when(m/^command$/i) {$sort_col = 'command';}
                    default             {print "Cannot sort by \'$1\'.\n";}
                }
            }
            when(m/^quit/i) {exit;}
            default {print "Input \'$user_input\' not recognized.\n";}
        }
        # A little whitespace before starting all over.
        print "\n";
    } #while
} #main

################################################################################
# SUBROUTINES
################################################################################

# Read_Parse_Top
# Sort_Increasing
# Sort_Decreasing
# Print_Data

########################################
# Subroutine
#
# $_[0]
#   Must be an array passed in by reference. This array should contain refs;
#   each ref points to a "top output" hash.
########################################

sub Read_Parse_Top {
    my $hashes = shift;
    my @top_output = ();
    my @split_line = ();
    @$hashes = (); # this array is about to be populated

    open(TOP, $TOP_CMD) or die("Cannot create pipe to \'top\' program: $!\n");
    @top_output = <TOP>;
    close(TOP) or die("Cannot close pipe to \'top\' program: $!\n");

    # discard first seven lines, plus the last line
    @top_output = @top_output[7 .. ($#top_output - 1)];
    # parse each line
    foreach (@top_output) {
        chomp;
        s/^\s+//; # Strip leading...
        s/\s+$//; # ...and trailing whitespace.
        @split_line = split;

        push(
            @$hashes,
            +{
                pid     => $split_line[0],
                user    => $split_line[1],
                pr      => $split_line[2],
                ni      => $split_line[3],
                virt    => $split_line[4],
                res     => $split_line[5],
                shr     => $split_line[6],
                s       => $split_line[7],
                cpu     => $split_line[8],
                mem     => $split_line[9],
                time    => $split_line[10],
                command => $split_line[11],
            }
        ); #push
    } #foreach
} #sub

########################################
# Subroutine
#
# $_[0]
#   Must be a scalar string value. This scalar determines by which column
#   top output will be sorted. The currenly acceptable values are 'pid', 'user',
#   'cpu', 'mem', and 'command'.
# $_[1]
#   Must be an array passed in by reference. This array should contain refs;
#   each ref points to a "top output" hash.
########################################

sub Sort_Increasing {
    my $sort_key = shift;
    my $arr_ref = shift;

    # Some columns need to be sorted numerically, others by string comparison.
    given($sort_key) {
        when(/pid|cpu|mem/)  {@$arr_ref = sort {   $a->{$sort_key}  <=>    $b->{$sort_key}}  @$arr_ref;} # 1-9
        when(/user|command/) {@$arr_ref = sort {lc($a->{$sort_key}) cmp lc($b->{$sort_key})} @$arr_ref;} # a-z
        default {die("There was an error choosing how to sort inside sub Sort_Increasing. The key \'$sort_key\' was not recognized.\n");}
    }
}

########################################
# Subroutine
#
# $_[0]
#   Must be a scalar string value. This scalar determines by which column
#   top output will be sorted. The currenly acceptable values are 'pid', 'user',
#   'cpu', 'mem', and 'command'.
# $_[1]
#   Must be an array passed in by reference. This array should contain refs;
#   each ref points to a "top output" hash.
########################################

sub Sort_Decreasing {
    my $sort_key = shift;
    my $arr_ref = shift;

    given($sort_key) {
        when(/pid|cpu|mem/)  {@$arr_ref = sort {   $b->{$sort_key}  <=>    $a->{$sort_key}}  @$arr_ref;} # 9-1
        when(/user|command/) {@$arr_ref = sort {lc($b->{$sort_key}) cmp lc($a->{$sort_key})} @$arr_ref;} # z-a
        default {die("There was an error choosing how to sort inside sub Sort_Increasing. The key \'$sort_key\' was not recognized.\n");}
    }
}

########################################
# Subroutine
#
# $_[1]
#   Must be an array passed in by reference. This array should contain refs;
#   each ref points to a "top output" hash.
########################################

sub Print_Data {
    # Points to an array. This array holds refs, each one pointing to a hash.
    my $array_ref = shift;

    open(MORE, $MORE_CMD) or die("Cannot create pipe to \'more\' program: $!\n");
    print MORE ("  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND\n");
    foreach my $hash_ref (@$array_ref) {
        printf MORE (
            " %4d %-8.8s %3.3s %3d %5.5s %4.4s %4.4s %1.1s %4.1f %4.1f %9.9s %-15.15s\n",
            $hash_ref->{pid}, $hash_ref->{user}, $hash_ref->{pr}, $hash_ref->{ni}, $hash_ref->{virt}, $hash_ref->{res}, $hash_ref->{shr}, $hash_ref->{s}, $hash_ref->{cpu}, $hash_ref->{mem}, $hash_ref->{time}, $hash_ref->{command}
        );
    } # foreach
    close(MORE) or die("Cannot close pipe to \'more\' program: $!\n");
}

################################################################################
# JUNKYARD
################################################################################
