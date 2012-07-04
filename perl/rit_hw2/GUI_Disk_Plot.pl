#!/usr/bin/perl
use strict;
use warnings;
use Cwd;                    # for changing directories
use Tk;

# TESTING
#use Readonly;

################################################################################
# DESCRIPTION
#
# Script Name:              GUI_Disk_Plot.pl
# Original Creation Date:   Jan 30, 2012
# Author(s):                Jeremy Audet
#
# This program is made for Windows OSs. This program depends upon the 'diruse'
# utility being present. This program formats the output of the 'diruse' utility
# so as to be easier to understand.
#
# Usage:
# perl GUI_Disk_Plot.pl [-z] [dir_path]
#
# Arguments:
# dir_path
#   The contents of this directory will be used when plotting disk usage.
# -z
#   If this argument is passed, then all subdirectories that consume 0% of the
#   parent directory will not be shown.
#
# Useful tags in this file:
# PRODUCTION
# TESTING
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################

# TESTING
#Readonly::Scalar my $ARG_Z              => '-z';
#Readonly::Scalar my $PATHNAME_CHARS     => 20;

# PRODUCTION
my $ARG_Z                               = '-z';
my $PATHNAME_CHARS                      = 20;

my $arg_z                               = undef;# Was the argument ARG_Z passed when this script was called? undef if false, 1 if true.
my @diruse_output                       = ();   # Output from 'diruse' command.
my %dir_size_pairs                      = ();   # Hash holding directory name key => absolute size pairs. 
my $number_format                       = '?';  # Holds a string such as 'b' or 'mb'.
my $total_size                          = 0;    # What is the total size of the current directory?

################################################################################
# MAIN
################################################################################

&Parse_Arguments();
&Run_Diruse();
&Get_Names_Sizes(\@diruse_output, \%dir_size_pairs);
# Are the numbers output by 'diruse' bytes, megabytes, or what?
if($diruse_output[0] =~ m/^\s*\S+\s+\((\S+)\)/) {
    $number_format = $1;
}
if($diruse_output[-1] =~ m/^\s*(\S+)/) {
    $total_size = $1;
    $total_size =~ s/,//g;
}
$#diruse_output = -1; # Done with array. Destroy it.
&Build_GUI(\%dir_size_pairs, $total_size, $number_format, $arg_z);
&MainLoop();

################################################################################
# SUBROUTINES
################################################################################

# Print a summary of how to use this program.
sub Print_Usage {
    print 'Usage: GUI_Disk_Plot.pl [-z] [dir_path]' . "\n";
}

# Validate and take action on all arguments that were passed to this program.
sub Parse_Arguments {
    # make sure each argument is valid
    SWITCH: {
        # case 0:
        # The current directory will be used when plotting disk usage.
        scalar(@ARGV) == 0 && do {
            last SWITCH;
        };

        # case 1:
        # $ARGV[0] must point to an existing directory
        scalar(@ARGV) == 1 && do {
            unless(-d $ARGV[0]) {
                &Print_Usage();
                die("Path does not exist: \'$ARGV[0]\'\n");
            }
            chdir($ARGV[0]) || die("Cannot change to directory: $ARGV[0]\n");
            last SWITCH;
        };

        # case 2:
        # $ARGV[0] must eq '-z'
        # $ARGV[1] must point to an existing directory
        scalar(@ARGV) == 2 && do {
            if($ARGV[0] ne $ARG_Z) {
                &Print_Usage();
                die("Argument not recognized: \'$ARGV[0]\'\n");
            }
            $arg_z = 1;
            unless(-d $ARGV[1]) {
                &Print_Usage();
                die("Path does not exist: \'$ARGV[1]\'\n");
            }
            chdir($ARGV[1]) or die("Cannot change to directory: $ARGV[1]\n");
            last SWITCH;
        };

        # case default:
        &Print_Usage();
        die("Incorrect number of arguments.\n");
    }
}

# This sub will run the 'diruse' command on the current directory and stuff the
# output into @diruse_output. One should already have changed to the appropriate
# directory before running this command.
sub Run_Diruse {
    # PRODUCTION
    #open(DIRUSE, 'diruse /* . |') or die("Cannot execute \'diruse\'.\n");
    # TESTING
    open(DIRUSE, 'diruse_sample_1') or die("Cannot open file containing sample diruse output.\n");
    #open(DIRUSE, 'diruse_sample_2') or die("Cannot open file containing sample diruse output.\n");
    @diruse_output = <DIRUSE>;
    close(DIRUSE) or die("Cannot close \'diruse\'.\n");
}

# Build the GUI for this program.
sub Build_GUI {
    # Read arguments.
    my $in_hash_ref     = shift;
    my $total_size      = shift;
    my $units           = shift;
    my $arg_z           = shift;

    # Create normal perl varaibles.
    my $sized_pathname  = '';
    my $percentage      = 0;
    my $percent_bar     = '';

    # Create and initialize Tk objects.
    my $window          = MainWindow -> new;
    my $dir_label       = $window -> Label  (-text          => &getcwd());
    my $display         = $window -> Scrolled('Text',
                                             -scrollbars    => 'oe',
                                             -height        => 24,
                                             -width         => $PATHNAME_CHARS + 1 + 50 + 1 + 6);
    # -width => width of resized pathname + space + max histogram size (50 chars) + space + percentage display (6 chars)

    # Set remaining properties of Tk objects and create a layout.
    $window             -> title("GUI_Disk_Plot.pl");
    $dir_label          -> grid(-row         => 1,
                                -column      => 1);
    $display            -> grid(-row         => 2,
                                -column      => 1);

    foreach my $key (keys(%$in_hash_ref)) {
        # Truncate pathname if necessary.
        if($PATHNAME_CHARS < length($key)) {
            $key =~ m/(.{$PATHNAME_CHARS})$/;
            $sized_pathname = $1;
        } else {
            $sized_pathname = $key . (' ' x ($PATHNAME_CHARS - length($key)));
        }

        # Find percentage value and create histogram bar.
        $percentage = int(($$in_hash_ref{$key} / $total_size) * 100);
        $percent_bar = '#' x ($percentage / 2);

        SWITCH: {
            # case $percentage == 100
            $percentage == 100 && do {
                $display->insert('end', "$sized_pathname ($percentage%) $percent_bar\n");
                last SWITCH;
            };
            # case $percentage >= 10
            $percentage >= 10  && do {
                $display->insert('end', "$sized_pathname ( $percentage%) $percent_bar\n");
                last SWITCH;
            };
            # case $percentage >= 1
            $percentage >= 1   && do {
                $display->insert('end', "$sized_pathname (  $percentage%) $percent_bar\n");
                last SWITCH;
            };
            # case default: (percentage must be 0)
            unless($arg_z) {
                $display->insert('end', "$sized_pathname (  $percentage%) $percent_bar\n");
            }
        } # switch case
    } # foreach key in pathname-size hash
    $display->insert('end', "TOTAL: $total_size $number_format\n");
} # Build_GUI

sub Get_Names_Sizes {
    my $in_arr_ptr = shift;
    my $out_hash_ptr = shift;

    for(my $i = 0; $i < scalar(@$in_arr_ptr); $i++) {
        # if:
        #   a row starts with a number
        #   there are four or more columns in that row
        # then:
        #   the first column is the absolute directory size
        #   the fourth column is a directory name
        #
        # Also note that the fourth column may contain whitespace.
        #
        # Numbers may be of arbitrary length, and may contain dots (.) and
        # commas (,). Examples of valid numbers:
        # 1
        # 1234567
        # 12.34567
        # 12,345.67
        # 1,234,567
        if(($$in_arr_ptr[$i] =~ m/^\s*\d/) and ($$in_arr_ptr[$i] =~ m/^\s*(\S+)\s+\S+\s+\S+\s+(.+)\s*$/)) {
            $$out_hash_ptr{$2} = $1;
            $$out_hash_ptr{$2} =~ s/,//g;
        }
    }
}

################################################################################
# TEMPLATES
################################################################################

# $txt_plot->insert(‘end’, “String to insert\n”);
