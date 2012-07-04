#!/usr/bin/perl
use strict;
use warnings;

################################################################################
# DESCRIPTION
#
# Script Name:              glue.pl
# Original Creation Date:   Jan 11, 2012
# Original Author:          Jeremy Audet
#
# This program accepts input from STDIN.
# If the -i switch is specified, all input is converted to lower case.
# Input is then piped to an outside program, PROGRAM.
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################
use constant TRUE           => 1;
use constant FALSE          => 0;
use constant PROGRAM        => './WordFreq2.pl';
use constant ARG_CASE_INSENSITIVE  => '-i';

my $arg_case_insensitive    = FALSE;
my $line                    = '';

################################################################################
# MAIN
################################################################################

&Check_Arguments();

# This script pipes all input to PROGRAM.
open(PIPEOUT, '| ' . PROGRAM . '') || die("Cannot create pipe to program \'" . PROGRAM . "\': $!\n");

if(FALSE == $arg_case_insensitive) {
    # Feed input to word-counting utility as-is.
    while(my $line = <STDIN>) { 
        print PIPEOUT "$line";
    }
} elsif(TRUE == $arg_case_insensitive) {
    # Outside programs will "inherit" STDIN from this program, so long as this
    # program never touches STDIN.
    open(PIPEIN_TR, "tr \'[:upper:]\' \'[:lower:]\' |") || die("Cannot open pipe to tr utility: $!\n");
    while(my $line = <PIPEIN_TR>) {
        print PIPEOUT "$line";
    }
    close(PIPEIN_TR) || die("Cannot close pipe to tr utility: $!\n");
} else {
    print STDERR "There was an error handling the arguments passed to this program.\n";
    print STDERR "More info: \$arg_case_insensitive: \'$arg_case_insensitive\'\n";
    print STDERR "Please report this problem to the system administrator or program maintainer.\n";
    exit;
}

# Done piping input to PROGRAM.
close(PIPEOUT) || die("Cannot close pipe to program \'" . PROGRAM . "\': $!\n");

################################################################################
# SUBROUTINES
################################################################################

sub Check_Arguments {
    foreach my $arg (@ARGV) {
        SWITCH: {
            $arg eq ARG_CASE_INSENSITIVE && do {$arg_case_insensitive = TRUE; last SWITCH;};
            # case default:
            print STDERR "Argument not recognized: \'$arg\'\n";
            exit;
        }
    }
}

################################################################################
# TEMPLATES
################################################################################
# tr [:upper:] [:lower:] < infile
# cat infiles* | tr [:upper:] [:lower:]
