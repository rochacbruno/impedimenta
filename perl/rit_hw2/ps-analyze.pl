#!/usr/bin/perl
use strict;
use warnings;
use Readonly;

################################################################################
# DESCRIPTION
#
# Script Name:              ps-analyze.pl
# Original Creation Date:   Feb 2, 2012
# Original Author:          Jeremy Audet
# 
# Usage:
# ps-analyze is a menu-driven program. It does not accept any arguments, and
# will ignore any given to it.

# This program reads the output of the 'pd -ef' command. The output is
# reformatted to get some interesting stats. The options are available to the
# user:
# 1) Process Frequency (CMD) Report
# 2) UID Report
# 3) Refresh ps -ef output
# 4) Quit
# 
# Example of option 1 output:
# <num_of_appearances> <UID>
#
# Example of option 2 output:
# <num_of_appearances> <CMD>
#
# Example of option 3 output:
# Reading 'ps -ef' output...
# Parsing 'ps -ef' output...
# Refresh done!
#
# Example of option 4 output:

# Interesting tags in this file:
# SUB
# TODO

################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################

Readonly::Scalar my $MIN_MENU_NUM       => 1;
Readonly::Scalar my $MAX_MENU_NUM       => 4;

my %col_CMD                             = ();
my %col_UID                             = ();
my $user_input                          = '';

################################################################################
# MAIN
################################################################################

&Read_Parse_Output();
while(1) {
    $user_input = &Get_Input();
    SWITCH: {
        $user_input == (int($MIN_MENU_NUM) + 0) && do { &Print_CMD_Report();    last SWITCH; };
        $user_input == (int($MIN_MENU_NUM) + 1) && do { &Print_UID_Report();    last SWITCH; };
        $user_input == (int($MIN_MENU_NUM) + 2) && do { &Read_Parse_Output();   last SWITCH; };
        $user_input == (int($MIN_MENU_NUM) + 3) && do { exit;                   last SWITCH; };
        print "Error: make a menu selection by entering a number in the range $MIN_MENU_NUM to $MAX_MENU_NUM.\n";
    };
}

################################################################################
# SUBROUTINES
################################################################################

######################################## SUB
# Open a pipe to the 'ps' program, and read the output of 'ps -ef'. Use this
# info to populate the %col_CMD and %col_UID hashes.
sub Read_Parse_Output {
    my $line        = '';
    my @split_line  = ();
    %col_CMD        = ();
    %col_UID        = ();

    print "Reading and parsing 'ps -ef' output...\n";
    open(PS, 'ps -ef |') or die("Error: Cannot execute command \'ps -ef |\'\n$!\n");
    foreach $line (<PS>) {
        # Split line into words. Note that the eighth column, 'CMD', may
        # contain whitespace. As a result, $split_line[7] contains a command
        # name, while $split_line[8] (if present) contains argument to that
        # command.
        chomp($line);
        @split_line = split(/ +/, $line, 9);

        # UID
        if(defined($col_UID{$split_line[0]})) {
            $col_UID{$split_line[0]} += 1;
        } else {
            $col_UID{$split_line[0]}  = 1;
        }

        # CMD
        if(defined($col_CMD{$split_line[7]})) {
            $col_CMD{$split_line[7]} += 1;
        } else {
            $col_CMD{$split_line[7]}  = 1;
        }
    }
    close(PS) or die("Error: cannot close pipe to program 'ps'.\n$!\n");
    print "Done reading and parsing 'ps -ef' output.\n";
}

######################################## SUB
# Display a menu to the user, then get input. Does not return until valid input
# has been retreived. Returns the number (e.g. '4') of the menu option chosen.
sub Get_Input {
    my $num = 0;

    print "\n";
    print '' . ($MIN_MENU_NUM + 0) . ") Process Frequency (CMD) Report\n";
    print '' . ($MIN_MENU_NUM + 1) . ") UID Report\n";
    print '' . ($MIN_MENU_NUM + 2) . ") Refresh ps -ef output\n";
    print '' . ($MIN_MENU_NUM + 3) . ") Quit\n";
    # print "\n"; # This newline is specified in the assignment, but I think it
    # makes the output considerably harder to read.
    print "Choice>";
    chomp($num = <STDIN>);

    if($num !~ m/^\d+$/) {
        $num = $MIN_MENU_NUM - 1;
    }
    return $num;
}

######################################## SUB
# Print out stats telling how many commands start with the same command name.
# Note that the following two rows:
# evince /home/ichimonji10/documents/RIT 2012  Phase I Housing Selection Workbook.pdf
# evince /home/ichimonji10/documents/UC Bedroom Signup Form 12-13.pdf
# ...would produce a single line of output like this:
# 2 evince
sub Print_CMD_Report {
    if(%col_CMD) {
        foreach my $key (keys(%col_CMD)) {
            print ''.$col_CMD{$key}.' '.$key."\n";
        } # foreach
        print "\n";
    } # if
} # sub

######################################## SUB
# Print out stats telling how many processes have the same PID.
sub Print_UID_Report {
    if(%col_UID) {
        foreach my $key (keys(%col_UID)) {
            print ''.$col_UID{$key}.' '.$key."\n";
        } # foreach
        print "\n";
    } # if
} # sub

################################################################################
# TEMPLATES
################################################################################
