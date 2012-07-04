#!/usr/bin/perl
use strict;
use warnings;
use feature 'switch';

########################################
# Script Name:      fileinfo.pl
# Creation Date:    02/21/2012
# Author(s):        Jeremy Audet
#
# Usage: fileinfo.pl [some/directory]
#
# Program demonstrates the use of an object. Program scans a directory for files
# and describes each one using an object. User can then manipulate and query
# acual files using objects.
########################################

use lib '../lib';
use Cwd;
use File::Spec;
use Ichi10::File;
use Readonly;

Readonly::Scalar my $USAGE  => "Usage: fileinfo.pl [some/directory]";
my $path                    = '';    # path to files
my $all_files               = undef; # glob
my @filenames               = ();    # name of each file, without the full path
my @files                   = ();    # array of File objects

# Read arg, if any.
# Path may be relative. Ensure it is absolute.
given(scalar @ARGV) {
    when(0) {$path = '.';}
    when(1) {$path = shift;}
    default {die $USAGE."\n";}
}
$path = Cwd::abs_path($path);

# Get a list of files. Clean up list, then create Ichi10::File objects.
opendir($all_files, $path) or die("Could not create glob from \'$path\': $!\n");
@filenames = readdir($all_files);
closedir($all_files) or die("Could not close glob: $!\n");
@filenames = File::Spec->no_upwards(@filenames); # get rid of '.' and '..'
foreach my $file (@filenames) {
    $file = File::Spec->catfile($path, $file);   # I want absolute filenames.
    push(@files, Ichi10::File->new($file));
}

# This is the user-facing portion of the script.
while(1) {
    print "1) list items\n";
    print "2) list an item\n";
    print "3) remove an item\n";
    print "4) print an item\n";
    print "5) quit\n";
    print "Choice => ";

    # get input, clean it up
    my $input = <STDIN>;
    chomp $input;
    $input =~ s/^\s+//; # strip whitespace
    $input =~ s/\s+$//;

    # have input, do something
    given($input) {
        when('1') {
            foreach my $file (@files) {
                print ''.$file->{name}."\n";
            }
        }
        when('2') {
            $files[ &Select_File(\@files) ]->list();
        }
        when('3') {
            my $index = &Select_File(\@files);  # get an index
            $files[$index]->delete();           # delete file
            splice(@files, $index, 1);          # delete object
        }
        when('4') {
            print $files[ &Select_File(\@files) ]->toString()."\n";
        }
        when('5') {
            exit;
        }
        default   {
            print "\'$input\' not recognized. Input must be a number in the range 1-5.\n";
        }
    }
    print "\n"; # Give a visual indication that the major program loop has run once.
}

########################################
# SUBROUTINE
#
# $_[0]
#   Ref to an array of Ichi10::File objects.
#   Returns an integer array index, based on which file object was selected.
########################################
sub Select_File {
    my $files = shift;
    die("No objects were passed to ".(caller(0))[3]."\n") unless scalar(@$files);

    while(1) {
        print "Select an item.\n";
        for(my $i = 0; $i < scalar(@$files); $i++) {
            print ''.($i + 1).") $files->[$i]->{name}\n";
        }
        print "Choice => ";

        my $input = <STDIN>;
        chomp $input;
        $input =~ s/^\s+//; # strip whitespace
        $input =~ s/\s+$//;
        if( ($input !~ /^\d+$/) or (0 >= $input) or (!exists($files->[$input - 1])) ) {
            print "\'$input\' not recognzied. Input must be a number in the range 1-".(scalar @$files).".\n";
        } else {
            return ($input - 1);
        }
    } # while(1)
}
