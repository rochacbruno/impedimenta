#!/usr/bin/perl
use strict;
use warnings;

################################################################################
# DESCRIPTION
#
# Script Name:              SimpleCalc.pl
# Original Creation Date:   Jan 6, 2012
# Original Author:          Jeremy Audet
#
# This script implements a simple command-line calculator. It supports the
# addition, subtraction, multiplication, and division operators (+, -, *, /).
# Script does not allow division by zero. User can terminate script by pressing
# Ctrl-c or Ctrl-d (dependent upon platform).
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################

# operators
use constant ADD            => '+';
use constant SUBTRACT       => '-';
use constant MULTIPLY       => '*';
use constant DIVIDE         => '/';

use constant VALID          => 1;
use constant INVALID        => 0;

my $accumulator             = 0;
my $operator                = '';
my $operand                 = 0;

################################################################################
# SUBROUTINES
################################################################################

################################################################################
# MAIN
################################################################################

print "Welcome to the simple, command-line calculator\n"
    . "\n";

while(1) {
    # ACCUMULATOR
    print "accumulator: $accumulator\n";

    # OPERATOR
    print "operator:    ";
    chomp($operator = <STDIN>);
    while((ADD ne $operator) && (SUBTRACT ne $operator) && (MULTIPLY ne $operator) && (DIVIDE ne $operator)) {
        print "error\n";
        print "invalid operator; valid operators are: + - * /\n";
        print "operator:    ";
        chomp($operator = <STDIN>);
    }

    # OPERAND
    print "operand:     ";
    chomp($operand = <STDIN>);
    while(($operand !~ /^\d+$/) || ((DIVIDE eq $operator) && (0 == $operand))) {
        if($operand !~ /^\d+$/) {
            print "error\n";
            print "operator must be a number\n";
        } else {
            print "error\n";
            print "cannot divide by 0\n";
        }
        # grab input again
        print "operand:     ";
        chomp($operand = <STDIN>);
    }

    # switch-case to perform (addition OR subtraction OR multiplication OR divison)
    SWITCH: {
        $operator eq ADD        && do {$accumulator += $operand; last SWITCH;};
        $operator eq SUBTRACT   && do {$accumulator -= $operand; last SWITCH;};
        $operator eq MULTIPLY   && do {$accumulator *= $operand; last SWITCH;};
        $operator eq DIVIDE     && do {$accumulator /= $operand; last SWITCH;};

        # case default:
        print STDERR "invalid operand\n";
        print STDERR "this is a bug; please report\n";
        exit;
    }
    print "\n";
}

print "\n"
    . "bye\n";

################################################################################
# CODE CHUNKS
################################################################################
# print "accumulator: ";
# print "operator:    ";
# print "operand:     ";
