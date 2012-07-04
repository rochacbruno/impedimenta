#!/usr/bin/perl
use strict;
use warnings;
use Cwd;
use feature 'switch';

################################################################################
# DESCRIPTION
################################################################################

# Script Name:      treewalk.pl
# Creation Date:    02/16/2012
# Author(s):        Jeremy Audet

# Usage:
# perl treewalk.pl /path/to/tree/root
#
# This script accepts only one argument. If more than one arguments are given,
# they will be ignored. If zero arguments are given, the suggested syntax will
# be shown.

################################################################################
# MAIN
################################################################################

die("Usage: perl treewalk.pl </path/to/tree/root>\n") unless(@ARGV);
chdir(shift @ARGV) or die("Cannot use path given: $!\n");
&Print_Tree();

################################################################################
# SUBROUTINES
################################################################################

# foreach file
#   print file stats
# foreach directory
#   cd into directory
#   call this function
#   cd ..

sub Print_Tree {
    my $all_files   = undef;    # glob of _all_ files and dirs in cwd
    my @files       = ();       # files in cwd
    my @dirs        = ();       # dirs in cwd
    my $cwd         = cwd();

    # get list of files and directories
    opendir($all_files, $cwd) or die("Exiting. Could not create glob from $cwd: $!\n");
    while(readdir $all_files) {
        given($_) {
            when(/^\.{1,2}$/)   {;}
            when(-d)            {push(@dirs,  $_);}
            default             {push(@files, $_);}
        }
    }
    closedir($all_files);
    $all_files = undef;

    # Print out stats about files, then recurse.
    while(my $filename = shift(@files)) {
        my $r = (-r $filename)? 'r': '-';
        my $w = (-w $filename)? 'w': '-';
        my $x = (-x $filename)? 'x': '-';
        print "$r$w$x ".$cwd.'/'.($filename)."\n";
    }
    while(my $dirname = shift(@dirs)) {
        chdir($dirname) or do {warn("ERR \'$!\' $cwd/$dirname\n"); next;};
        &Print_Tree();
        chdir('../');
    }
}
