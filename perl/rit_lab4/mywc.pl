#!/usr/bin/perl
use strict;
use warnings;

################################################################################
# DESCRIPTION
#
# Script Name:              mywc.pl
# Original Creation Date:   Jan 08, 2012
# Original Author:          Jeremy Audet
#
# A simplified clone of the 'wc' *nux utility. Determines how many lines,
# words, and characters are present in a given set of files.
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################
my $lines_in_total          = 0;
my $words_in_total          = 0;
my $chars_in_total          = 0;
my @lines_per_file          = ();
my @words_per_file          = ();
my @chars_per_file          = ();

################################################################################
# MAIN
################################################################################

# check for arguments
if(scalar(@ARGV) == 0) {
    print "Oh noes! Not enough arguments.\n";
    print "Usage: mywc.pl filename [filename ...]\n";
    exit;
}

# parse files, and populate global variables
foreach my $filename (@ARGV) {
    # create file-specific variables
    my $lines_in_file = 0;
    my $words_in_file = 0;
    my $chars_in_file = 0;
    # open a file
    open(FILE, $filename) or die "Cannot open file \'$filename\': $!\n";

    # read a file, one line at a time
    while(my $line = <FILE>) {
        # this matches wc behavour
        if($line =~ /\n/) {
            $lines_in_file++;
        }
        # split() treats leading or trailing whitespace as a word. Ignore this
        # whitespace when counting words.
        $line =~ /^[\s]*(.+)[\s]*$/;
        if(defined($1)) {
            $words_in_file += scalar(split(/\s+/, $1));
        }
        $chars_in_file += scalar(length($line));
    }
    # update totals
    $lines_in_total += $lines_in_file;
    $words_in_total += $words_in_file;
    $chars_in_total += $chars_in_file;
    push(@lines_per_file, $lines_in_file);
    push(@words_per_file, $words_in_file);
    push(@chars_per_file, $chars_in_file);

    close(FILE) or die "Cannot close file \'$filename\': $!\n";
}

# Determine formatting information.
my @col_names   = qw(lines words chars filename);
my @totals      = ($lines_in_total, $words_in_total, $chars_in_total, 'total');
my @row_widths  = (0, 0, 0);
$row_widths[0]  = &find_longest_arg($col_names[0], $lines_in_total);
$row_widths[1]  = &find_longest_arg($col_names[1], $words_in_total);
$row_widths[2]  = &find_longest_arg($col_names[2], $chars_in_total);
$row_widths[3]  = &find_longest_arg($col_names[3], @ARGV); # @ARGV is treated as a collection of scalars in the sub

# print divider before and after list of files
print ''  . ('-' x (3 + $row_widths[0] + $row_widths[1] + $row_widths[2] + $row_widths[3])) . "\n";
# print stats for all files, one line of output per file
for(my $i = 0; $i < scalar(@ARGV); $i++) {
    print ''  . (' ' x ($row_widths[0] - length($lines_per_file[$i]))) . ''  . $lines_per_file[$i];
    print ''  . (' ' x ($row_widths[1] - length($words_per_file[$i]))) . ' ' . $words_per_file[$i];
    print ''  . (' ' x ($row_widths[2] - length($chars_per_file[$i]))) . ' ' . $chars_per_file[$i];
    print ' ' . $ARGV[$i];
    print "\n";
}
print ''  . ('-' x (3 + $row_widths[0] + $row_widths[1] + $row_widths[2] + $row_widths[3])) . "\n";

# print totals, if appropriate
if(scalar(@ARGV) > 1) {
    print ''  . (' ' x ($row_widths[0] - length($totals[0]))) . ''  . $totals[0];
    print ''  . (' ' x ($row_widths[1] - length($totals[1]))) . ' ' . $totals[1];
    print ''  . (' ' x ($row_widths[2] - length($totals[2]))) . ' ' . $totals[2];
    print ' ' . $totals[3];
    print "\n";
}

# print column labels
print ''  . (' ' x ($row_widths[0] - length($col_names[0]))) . ''  . $col_names[0];
print ''  . (' ' x ($row_widths[1] - length($col_names[1]))) . ' ' . $col_names[1];
print ''  . (' ' x ($row_widths[2] - length($col_names[2]))) . ' ' . $col_names[2];
print ' ' . $col_names[3];
print "\n";

################################################################################
# SUBROUTINES
################################################################################
sub find_longest_arg {
    if(scalar(@_) <= 0) {
        print 'ERROR: ' . (caller(0))[3] . ' requires one or more arguments. Was passed ' . scalar(@_) . " arguments\n";
        exit;
    }

    my $max_len = 0;
    foreach my $arg (@_) {
        if(length($arg) > $max_len) {
            $max_len = length($arg);
        }
    }
    return $max_len;
}

################################################################################
# TEMPLATES
################################################################################
