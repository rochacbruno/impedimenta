#!/usr/bin/perl
use strict;
use warnings;

# use diagnostics;

use File::DirWalk;
use Date::EzDate;

########################################
# DESCRIPTION
########################################
# Script Name:      findold.pl
# Creation Date:    02/17/2012
# Author(s):        Jeremy Audet
#
# This program walks a directory tree and finds old files.
#
# Usage: perl findold.pl /home/foo 2/17/2012 12:30:00
#
# The first argument is the directory which will be recursively searched for
# files. The path may be either absolute or relative.
#
# The second and third argument specify the date used when finding files. Files
# older than the date specified will be printed out. The date must be written as
# mm/dd/yyyy. mm and dd can be contracted to m and d, respectively. The time is
# written in the format hh:mm:ss. Seconds may be omitted, and :00 will be
# assumed.

########################################
# GLOBAL DECLARATIONS
########################################

my $age = 0;
my $USAGE = "Usage: findold.pl <path> <mm/dd/yy> <hh:mm[:ss]>\n";

########################################
# MAIN
########################################

(scalar(@ARGV) == 3) or die($USAGE);

{ # prevent "my" variables from being seen throughout rest of file
    my $path = shift(@ARGV);
    my $date = shift(@ARGV);
    my $time = shift(@ARGV);

    # Verify $path, $date, and $time. Then assign a value to $age.
    die("Could not find $path: $!\n") unless(-d $path);
    $date =~ /^\d{1,2}\/\d{1,2}\/\d{4}$/ or die($USAGE);
    { # create a block for $1
        $time =~ /^\d{1,2}:\d{1,2}(:\d{1,2})?$/ or die($USAGE);
        if(defined($1)) {
            $age = Date::EzDate->new("$date $time")->{'epoch second'};
        } else {
            $age = Date::EzDate->new("$date $time:00")->{'epoch second'};
        }
    }

    # Start recursing!
    my $walker = new File::DirWalk;
    $walker->onFile(\&Check_File);  # Tell the object what sub to call.
    $walker->walk($path);           # The directory to walk.
}

########################################
# SUBROUTINE
########################################
# This sub checks to see if a file is older than a specified date. If so, the
# filename and date of last access are printed.

sub Check_File {
    my $filename = shift(@_);
    my @file_info = stat($filename);
    # [8] is last accesss time, in seconds from the epoch
    my $access_time = $file_info[8];

    if($access_time < $age) {
        my $formatter = Date::EzDate->new();
        $formatter->{'epoch second'} = $access_time;

        print "$filename\n";
        print "    Last Accessed: ".$formatter->{'{month short} {day of month}, {year} {hour}:{min}:{sec}'}."\n";
    }

    File::DirWalk::SUCCESS; # return true
}
