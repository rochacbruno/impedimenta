#!/usr/bin/perl
use strict;
use warnings;
use Cwd;
use File::Spec;

########################################
# Script Name:      part2.pl
# Creation Date:    02/23/2012
# Author(s):        Jeremy Audet
#
# This is my attempt at perl lab 8, part 2. This script does nothing more than
# read in a list of all the files and directories inside the current directory.
# The list of files and folders is then printed back out to the user.
########################################

########################################
# MAIN
########################################

my $path = Cwd::abs_path('.');
my $thing = ''; # the name of a file or directory

print "Files:\n";
foreach $thing (&Get_Files($path)) {
    print "    $thing\n";
}
print "Directories:\n";
foreach $thing (&Get_Dirs($path)) {
    print "    $thing\n";
}

########################################
# SUBROUTINE
# Looks through the current directory to find a list of all files. Places the
# name of each file into an array, then returns the array.
#
# $_[0]
#   Scalar string. The path to search for files.
########################################

sub Get_Files {
    my $path        = shift;# what path will be searched?
    my $dir_glob    = undef;# glob of all things in $path
    my $thing       = '';   # a single thing from the glob
    my @files       = ();   # all files from the glob

    opendir($dir_glob, $path) or die("Could not read directory $path: $!\n");
    foreach $thing (readdir $dir_glob) {
        if(-f $thing) {
            push(@files, $thing);
        }
    }
    closedir($dir_glob) or die("Could not close directory $path: $!\n");

    return @files;
}

########################################
# SUBROUTINE
# Looks through the current directory to find a list of all directories. Places
# the name of each directory into an array, then returns the array.
#
# $_[0]
#   Scalar string. The path to search for files.
########################################

sub Get_Dirs {
    my $path        = shift;# what path will be searched?
    my $dir_glob    = undef;# glob of all things in $path
    my $thing       = '';   # a single thing from the glob
    my @dirs        = ();   # all files from the glob

    # populate @dirs
    opendir($dir_glob, $path) or die("Could not read directory $path: $!\n");
    foreach $thing (readdir $dir_glob) {
        if(-d $thing) {
            push(@dirs, $thing);
        }
    }
    closedir($dir_glob) or die("Could not close directory $path: $!\n");

    # get rid of '.' and '..' before returning
    return File::Spec->no_upwards(@dirs);
}
