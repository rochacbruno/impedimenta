#!/usr/bin/perl
use strict;
use warnings;
use lib '../lib';
use Ichi10::StatUtils; # tools for finding thins like standard deviation
use Chart::Gnuplot;    # for the --image argument
use Getopt::Long;      # for reading arguments
use Cwd;               # for cleaning paths and generating absolute paths

{
    my @dependencies = qw(gnuplot cat);
    foreach my $dependency (@dependencies) {
        unless (`which $dependency 2>/dev/null`) {
            die("$dependency not found. Either install or add location of program to PATH.\n");
        }
    }
}

########################################
#   Summary
# Reads in the given file line-by-line. Expects each line to contain three
# fields: x value, y value, and type. Does some number crunching, and can output
# textual and graphical summaries.
########################################

#
# Get arguments.
#

my $arg_srcfile = ''; # file from which statistics will be read
my %args = (
    "height"    => 1,
    "width"     => 1,
    "title"     => "",
    "xlabel"    => "x axis",
    "ylabel"    => "y axis",
);

die unless Getopt::Long::GetOptions(
    \%args,
    "help",
    "verbose",
    "no-outliers",

    "text",

    "image=s",
    "width:f",
    "height:f",
    "title:s",
    "xlabel:s",
    "ylabel:s",
);
if($args{"help"}) {
    print "$0 is used for generating statistics about a set of x and y values.\n"
        . "Usage: $0 /path/to/data/file.txt\n"
        . "Options:\n"
        . "--help\n"
        . "  display this help message\n"
        . "--verbose\n"
        . "  Display debugging messages.\n"
        . "--no-outliers\n"
        . "  Remove outliers from data set before generating statistics.\n"
        . "--text\n"
        . "  Print out textual statistics.\n"
        . "--image /path/to/output/file.png\n"
        . "  Create a visual summary of statistics.\n"
        . "--width real.number\n"
        . "  Adjust the width of the image output. Default: " . $args{"width"} . "\n"
        . "--height real.number\n"
        . "  Adjust the height of the image output. Default: " . $args{"height"} . "\n"
        . "--title something_clever\n"
        . "  Only applicable if --image has been passed. Default: " . $args{"title"} . "\n"
        . "--xlabel something_clever\n"
        . "  Only applicable if --image has been passed. Default: " . $args{"xlabel"} . "\n"
        . "--ylabel something_clever\n"
        . "  Only applicable if --image has been passed. Default: " . $args{"ylabel"} . "\n"
        . "";
    exit;
}
unless ($arg_srcfile = shift @ARGV) {
    print "$0 --help\n"
        . "for help with this program\n";
    exit;
}

#
# Validate arguments
#

unless ($arg_srcfile = Cwd::abs_path($arg_srcfile)) {
    die "Path to data file is invalid.\n";
}
if ($args{"image"}) {
    my $backup = $args{"image"};
    unless ($args{"image"} = Cwd::abs_path($args{"image"})) {
        die "Cannot create image at specified location: $backup\n";
    }
}
if(0 >= $args{"height"}) {
    die "Height scaling factor must be greater than zero. Given: " . $args{"height"} . ")\n";
}
if(0 >= $args{"width"}) {
    die "Width scaling factor must be greater than zero. Given: " . $args{"width"} . ")\n";
}

#
# Read in data from text file.
#

my @data        = ();
my $discarded   = 0; # number of outliers removed from data set

if($args{"verbose"}) { print "Reading data set from $arg_srcfile.\n"; }
open(PIPE_IN_CAT, "cat \"$arg_srcfile\" |") or die("Cannot open pipe: $!\n");
foreach (<PIPE_IN_CAT>) {
    chomp;
    s/^\s+//; # strip leading and trailing whitespace
    s/\s+$//;

    my ($x, $y, $type) = split(/\s+/);
    if(($x !~ /^\d+(\.\d+)?$/) or ($y !~ /^\d+(\.\d+)?$/)) {
        warn "Skipping improperly formatted line: $_\n";
        next;
    }
    my %point = (
        X       => $x,
        Y       => $y,
        TYPE    => "uncategorized",
    );
    if($type) {
        $point{TYPE} = $type;
    }

    push(@data, \%point);
}
close(PIPE_IN_CAT) or die("Cannot close pipe: $!\n");
if($args{"verbose"}) { print scalar(@data) . " data points read from file.\n"; }

#
# Have data structures detailing audio files on hand. Remove outliers, if
# appropriate.
#

if($args{"no-outliers"}) {
    my ($x_vals, $y_vals) = &pop_lists(\@data, 0);
    my $stats = Ichi10::StatUtils::find_stats($x_vals, $y_vals);

    if($args{"verbose"}) { print "Removing outliers.\n"; }
    if($args{"verbose"}) { print "    upper fence: $stats->{X_UPPER_FENCE}\n"; }
    if($args{"verbose"}) { print "    lower fence: $stats->{X_LOWER_FENCE}\n"; }

    for(my $i = 0; $i < scalar(@data); $i++) {
        if(($data[$i]->{X} < $stats->{X_LOWER_FENCE}) or ($data[$i]->{X} > $stats->{X_UPPER_FENCE})) {
            splice(@data, $i, 1);
            $discarded++;
            $i--;
        }
    }

    if($args{"verbose"}) { print "    $discarded outliers found\n"; }
    if($args{"verbose"}) { print "    " . scalar(@data) . " data points remaining\n"; }
}

# Figure out what data types exist, and how many of each are present.
my %types = ();
foreach my $point (@data) {
    if(not $types{$point->{TYPE}}) { # typing
        $types{$point->{TYPE}} = 1;
    } else {
        $types{$point->{TYPE}}++;
    }
}
if($args{"verbose"}) {
    print "Found " . scalar(keys %types) . " data types.\n";
    foreach my $type (keys %types) {
        print "    type: $type ($types{$type})\n";
    }
}

#
# Have fully populated data structure with info about audio files. Time to
# generate stats about audio files.
#

if($args{"text"}) {
    if($args{"verbose"}) { print "Argument \"text\" is true. Printing stats.\n"; }

    {
        my ($x_vals, $y_vals) = &pop_lists(\@data, 0); # any type
        my $stats = Ichi10::StatUtils::find_stats($x_vals, $y_vals);
        my @keys = sort {$a cmp $b} keys(%$stats);

        print "stats for entire data set\n";
        foreach my $key (@keys) {
            print "$key: $stats->{$key}\n";
        }
        print "\n";
    }

    foreach my $type (keys %types) {
        my ($x_vals, $y_vals) = &pop_lists(\@data, $type);
        my $stats = Ichi10::StatUtils::find_stats($x_vals, $y_vals);
        my @keys = sort {$a cmp $b} keys(%$stats);

        print "stats for category: $type\n";
        foreach my $key (@keys) {
            print "$key: $stats->{$key}\n";
        }
        print "\n";
    }
}

if($args{"image"}) {
    if($args{"verbose"}) { print "Argument \"image\" is true. Generating image.\n"; }

    # chart does not yet have any data sets to act on
    my @datasets = ();
    my $chart = Chart::Gnuplot->new(
        "title"     => $args{"title"} . " (" . scalar(@data) . " shown, $discarded discarded)",
        "output"    => $args{"image"}, # location of image generated
        "xlabel"    => $args{"xlabel"},
        "ylabel"    => $args{"ylabel"},
        "imagesize" => sprintf("%f, %f", $args{"width"}, $args{"height"}), # relative to default size
        "bg"        => '#FFFFFF',
#        "extra_opts" => "set key left top", # FAILS?!
    );

    # Generate a regression line for the data set as a whole.
    {
        my ($x_vals, $y_vals) = &pop_lists(\@data, 0);
        my $stats = Ichi10::StatUtils::find_stats($x_vals, $y_vals);

        my $regression_line = Chart::Gnuplot::DataSet->new(
            title => sprintf("%s slope: %.2f (confidence %.4f)", "all points", $stats->{LSQRL_SLOPE}, $stats->{R2}),
            func  => "$stats->{LSQRL_SLOPE} * x  + $stats->{LSQRL_Y_INT}",
        );
        push(@datasets, $regression_line);
    }

    # Generate a scatterplot and regression line for each type.
    foreach my $type (keys %types) {
        my ($x_vals, $y_vals) = &pop_lists(\@data, $type);
        my $stats = Ichi10::StatUtils::find_stats($x_vals, $y_vals);

        my $scatterplot = Chart::Gnuplot::DataSet->new(
            title => "$type ($types{$type})",
            xdata => $x_vals,
            ydata => $y_vals,
        );
        push(@datasets, $scatterplot);

        my $regression_line = Chart::Gnuplot::DataSet->new(
            title => sprintf("%s slope: %.2f (confidence %.4f)", $type, $stats->{LSQRL_SLOPE}, $stats->{R2}),
            func  => "$stats->{LSQRL_SLOPE} * x  + $stats->{LSQRL_Y_INT}",
        );
        push(@datasets, $regression_line);
    }

    # finally -- generate the actual image
    if($args{"verbose"}) { print "Generating image.\n"; }
    $chart->plot2d(@datasets);
}

if($args{"verbose"}) { print "Goodbye.\n"; }

########################################
# END MAIN, START SUBROUTINES
########################################

# Summary
#   Given a set of hashes, extract the X and Y values from them. Create a set of
#   arrays, each containing a list of X or Y values, and return them. Can filter
#   out data points whose TYPE does not match the type given.
# Syntax
#   $_[0] Array ref. A series of hashes, each containing info about a single
#       data point.
#   $_[1] Scalar. Only hashes whose {TYPE} equals this argument will be added to
#       the lists of X and Y values.
sub pop_lists {
    my ($data, $type) = @_;
    my (@list1, @list2) = ();

    if($args{"verbose"}) { print "About to create lists from data set.\n"; }
    if($args{"verbose"}) { print "    type: " . ($type ? "$type" : 'any') . "\n"; }
    if ($type) {
        foreach my $point (@$data) {
            if($type eq $point->{TYPE}) {
                push(@list1, $point->{X});
                push(@list2, $point->{Y});
            }
        }
    } else {
        foreach my $point (@$data) {
            push(@list1, $point->{X});
            push(@list2, $point->{Y});
        }
    }
    if($args{"verbose"}) { print "    done populating lists\n"; }
    if($args{"verbose"}) { print "    list sizes: (" . scalar(@list1) . "," . scalar(@list2) . ")\n"; }

    return (\@list1, \@list2);
}
