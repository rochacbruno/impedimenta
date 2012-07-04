#!/usr/bin/perl
use strict;
use warnings;
use feature 'switch';
use Date::EzDate;
use Getopt::Std;

# use diagnostics;

use Readonly;

################################################################################
# DESCRIPTION
################################################################################

# Script Name:      compare_dates.pl
# Creation Date:    02/15/2012
# Author(s):        Jeremy Audet

# USAGE ################################

# perl compate_dates.pl [-(d|D)] <date_1> <date_2>
#
# <date_1> and <date_2> can be written any way that an EzDate time can be
# written. For example, the following are all valid.
# "October 31, 2009 4:06am"
# "October 31, 2009"
# "4:06am"
#
# The quotes are **required**.

# EXAMPLES #############################

# This script compares <date_1> and <date_2>. It'll tell you if <date_1> is
# earlier or later than <date_2>. Example:
#
# $ perl compare_dates.pl "December 25, 2009 4pm" "October 31, 2009 4pm"
# December 25, 2009 4pm is later than October 31, 2009 4pm

# If -d is passed, the difference in their dates will be calculated as: (date_1
# - date_2). Example:
#
# $ perl compare_dates.pl -d "December 25, 2009 4pm" "October 31, 2009 4pm"
# 55 days difference

# If -D is passed, both types of output are shown. Example:
#
# $ perl compare_dates.pl -D "December 25, 2009 4pm" "October 31, 2009 4pm"
# 55 days difference
# December 25, 2009 4pm is later than October 31, 2009 4pm

# -d and -D cannot be passed at the same time. Example:
#
# $ perl compare_dates.pl -Dd "December 25, 2009 4pm" "October 31, 2009 4pm"
# Error: -d and -D cannot be used at the same time.

# Interesting tags in this file:
# DIAGNOSTIC

################################################################################
# GLOBAL DECLARATIONS
################################################################################

Readonly::Scalar my $NUM_ARGS       => 2;   # This many elements remain in @ARGV after calling getopts().
Readonly::Scalar my $ARG_d          => 'd';
Readonly::Scalar my $ARG_D          => 'D';

################################################################################
# MAIN
################################################################################

{
    my %args                            = ();
    my ($date_1, $date_2)               = undef;

    # Turn off warning messages from EzDate. Then process arguments.
    $Date::EzDate::default_warning = 0;
    &Read_Args(\%args, \$date_1, \$date_2);

# DIAGNOSTIC
#     foreach my $key (keys %args) {
#         print "key:$key\n";
#     }
#     print "args{arg_d}:$args{$ARG_d}\n";
#     print "args{arg_D}:$args{$ARG_D}\n";

    # Print results.
    if($args{$ARG_d}) {
        print ''.($date_1->{'epoch day'} - $date_2->{'epoch day'})." days difference\n";
    } elsif($args{$ARG_D}) {
        print ''.($date_1->{'epoch day'} - $date_2->{'epoch day'})." days difference\n";
        if($date_1 < $date_2) {
            print "$date_1 is earlier than $date_2\n";
        } elsif ($date_1 > $date_2) {
            print "$date_1 is later than $date_2\n";
        } else {
            print "$date_1 is the same as $date_1\n";
        }
    } else {
        if($date_1 < $date_2) {
            print "$date_1 is earlier than $date_2\n";
        } elsif ($date_1 > $date_2) {
            print "$date_1 is later than $date_2\n";
        } else {
            print "$date_1 is the same as $date_1\n";
        }
    }#if
}#sub

################################################################################
# SUBROUTINES
################################################################################

########################################
# Subroutine
########################################
# Consume @ARGV and populate relevant data structures.
#
# $_[0]
#   Hash ref. This hash will be populated with keys like $ARG_d and $ARG_D. Any
#   pre-existing keys are destroyed.
#
# $_[1]
#   Scalar ref. A Date::EzDate object is assigned to this scalar.
#
# $_[2]
#   Scalar ref. A Date::EzDate object is assigned to this scalar.

sub Read_Args {
    my $args_ref                        = shift;
    my $date_1_ref                      = shift;
    my $date_2_ref                      = shift;

    # Only process switches preceded by a dash (-).
    %$args_ref = ();
    getopts('dD', \%$args_ref);
    if($args_ref->{$ARG_d} and $args_ref->{$ARG_D}) {
        die "Error: -d and -D cannot be used at the same time.\n";
    }

    # Only <date_1> and <date_2> should remain as arguments.
    unless($NUM_ARGS == scalar(@ARGV)) {
        die "Usage: perl compate_dates.pl [-(d|D)] <date_1> <date_2>\n";
    }

    # Error messages from EzDate have been suppressed.
    unless($$date_1_ref = Date::EzDate->new(shift @ARGV)) {
        die "$$date_1_ref formatted incorrectly.\n";
    }
    unless($$date_2_ref = Date::EzDate->new(shift @ARGV)) {
        die "date_2 formatted incorrectly.\n";
    }
}

################################################################################
# JUNKYARD
################################################################################

# 40 hash marks, then 80 hash marks
########################################
################################################################################
