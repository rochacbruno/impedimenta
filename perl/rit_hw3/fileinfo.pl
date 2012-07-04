#!/usr/bin/perl
use strict;
use warnings;
use Cwd;
use Date::EzDate;

# TESTING
# use Readonly;

################################################################################
# DESCRIPTION
################################################################################

# Script Name:              fileinfo.pl
# Original Creation Date:   2012/02/13
# Original Author:          Jeremy Audet

# Usage:
# perl fileinfo.pl <path_to_directory>

# This script will examine all regular files in <path_to_directory>, and print
# out some info about those files. Symbolic links, subdirectories, and other
# files are ignored. The info printed out for each file is:
    # complete file name (including path from root)
    # date and time of last modification
    # date and time of last access
    # file owner (name, not number)
    # file group (name, not number)

# Rubric items:
# runs OK
# get list of files using opendir, readdir, closedir, grep, and map
# get file info using stat
# Use Date::EzDate and 'epoch second' to format dates/times
# use getpwuid and getgrgid 
# output is formatted as per example:
    # /home/pete/perl/HW3/resources.pl
    #     Access = February 03, 2010 14:05:02
    #     Modify = February 03, 2010 13:43:42
    #     User = pete Group = pete
    # /home/pete/perl/HW3/fileinfo.pl
    #     Access = February 04, 2010 09:57:44
    #     Modify = February 04, 2010 09:57:41
    #     User = pete Group = pete
    # /home/pete/perl/HW3/fileinfo.pl~
    #     Access = February 04, 2010 09:57:16
    #     Modify = February 04, 2010 09:57:14
    #     User = pete Group = pete
    # /home/pete/perl/HW3/resources.pl~
    #     Access = February 03, 2010 13:30:59
    #     Modify = February 03, 2010 13:30:58
    #     User = pete Group = pete

# Interesting tags in this file:
# TESTING
# PRODUCTION

################################################################################
# GLOBAL DECLARATIONS
################################################################################

# The built-in 'stat' can be used to get information about a file. 'stat'
# returns an array containing 13 fields. Here are the ones I use.
#
# Numeric user ID of file's owner
# Numeric group ID of file's owner
# Last access time since the epoch
# Last modify time since the epoch

# TESTING
# Readonly::Scalar my $STAT_UID           => 4;
# Readonly::Scalar my $STAT_GID           => 5;
# Readonly::Scalar my $STAT_ACCESS        => 8;
# Readonly::Scalar my $STAT_MODIFY        => 9;

# PRODUCTION
my $STAT_UID                            = 4;
my $STAT_GID                            = 5;
my $STAT_ACCESS                         = 8;
my $STAT_MODIFY                         = 9;

# How many arguments are accepted by this program?

# TESTING
# Readonly::Scalar my $NUM_ARGS           => 1;

# PRODUCTION
my $NUM_ARGS                            = 1;

################################################################################
# MAIN
################################################################################

{
    # Check for args.
    if($NUM_ARGS != scalar(@ARGV)) {
        print "Usage: perl fileinfo.pl <path_to_directory>\n";
        exit;
    }

    # Declare and initialize variables.
    my $path                            = shift(@ARGV);
    my $all_files                       = undef;
    my @files                           = ();
    my $file                            = '';

    # Path given may be relative or absolute.
    $path = &Cwd::abs_path($path) or die("Cannot find path \'$path\': $!\n");

    # Get a glob of directory contents, filter out everything but files, and
    # make filenames absolute.
    opendir($all_files, $path) or die("Exiting. Could not create glob from \'$path\': $!\n");
    @files = map {$path . '/' . $_} grep {-f "$path/$_"} readdir($all_files);
    closedir($all_files) or die("Exiting. Could not close glob: $!\n");

    # This is the user-facing portion of the program.
    foreach $file (@files) {
        &Print_File_Info($file);
    }
}

################################################################################
# SUBROUTINES
################################################################################

########################################
# Subroutine
#
# $_[0]
#   Scalar. A path to a single file.
########################################

sub Print_File_Info {
    my $file        = shift;
    my @file_info   = stat($file);
    my $access_time = Date::EzDate->new();
    my $modify_time = Date::EzDate->new();
    $access_time->{'epoch second'} = $file_info[$STAT_ACCESS];
    $modify_time->{'epoch second'} = $file_info[$STAT_MODIFY];
    my $user_name   = getpwuid($file_info[$STAT_UID]);
    my $group_name  = getgrgid($file_info[$STAT_GID]);

    print "$file\n";
    print "        Access = " . $access_time->{'{month long} {day of month}, {year} {hour}:{minute}:{second}'} . "\n";
    print "        Modify = " . $modify_time->{'{month long} {day of month}, {year} {hour}:{minute}:{second}'} . "\n";
    print "        User = $user_name Group = $group_name\n";
}

################################################################################
# JUNKYARD
################################################################################
