#!/usr/bin/perl
use strict;
use warnings;
use Tk;

################################################################################
# DESCRIPTION
#
# Script Name:              TempConverter.pl
# Original Creation Date:   Jan 7, 2012
# Original Author:          Jeremy Audet
#
# This script implements a GUI-based temperature converter. It converts between
# fahrenheit and celsius. This script relies upon Tk library to create the GUI.
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################

################################################################################
# MAIN
################################################################################
ConstructGui();
MainLoop();

################################################################################
# SUBROUTINES
################################################################################
sub ConstructGui {
    ####################################
    # Declare and initialize normal perl variables.
    ####################################
    my $f_temp = 0;
    my $c_temp = 0;

    ####################################
    # Declare Tk objects. 
    # Initialize Tk objects.
    # Define semantics/behaviour of GUI elements.
    ####################################
    my $window              = MainWindow -> new;
    my $f_label             = $window->Label    (-text          => "Degrees F");
    my $f_entry             = $window->Entry    (-textvariable  => \$f_temp);
    my $f_convert_button    = $window->Button   (-text          => "Convert From Fahrenheit",
                                                 -command       => sub {&Convert_From_F(\$f_temp, \$c_temp)});
    my $c_label             = $window->Label    (-text          => "Degrees C");
    my $c_entry             = $window->Entry    (-textvariable  => \$c_temp);
    my $c_convert_button    = $window->Button   (-text          => "Convert From Celsius",
                                                 -command       => sub {&Convert_From_C(\$f_temp, \$c_temp)});
    my $quit_button         = $window->Button   (-text          => "Quit",
                                                 -command       => sub {$window->destroy});
    $window -> title("Temperature Converter");
    
    ####################################
    # Define presentation of program.
    ####################################

    # GUI-wide Settings ################
    # Setting the window size statically produces extremely ugly results.
    # $window                 -> geometry("500x300");
    # Row 1 Settings ###################
    $f_label                -> grid(-row        => 1,
                                    -column     => 1);
    $f_entry                -> grid(-row        => 1,
                                    -column     => 2);
    $f_convert_button       -> grid(-row        => 1,
                                    -column     => 3);
    # Row 2 Settings ###################
    $c_label                -> grid(-row        => 2,
                                    -column     => 1);
    $c_entry                -> grid(-row        => 2,
                                    -column     => 2);
    $c_convert_button       -> grid(-row        => 2,
                                    -column     => 3);
    # Row 3 Settings ###################
    $quit_button            -> grid(-row        => 3,
                                    -column     => 1,
                                    -columnspan => 3);
}

sub Convert_From_F {
    # Two arguments?
    if(2 != scalar(@_)) {
        print STDERR 'Invalid number of arguments. ' . (caller(0))[3] . 'takes two arguments.' . "\n";
    }
    # Fetch arguments.
    my $f_ref = shift;
    my $c_ref = shift;
    # Ensure given temperature is a valid number.
    if($$f_ref =~ /^[-]?[\d]+(\.[\d]+)?$/) {
        # Finally perform the temperature conversion.
        $$c_ref = ($$f_ref- 32.0) * (5.0/9.0);
    } else {
        print STDERR 'Invalid argument(s). ' . (caller(0))[3] . ' takes only numbers as arguments.' . "\n";
        print STDERR "args: <$$f_ref>,<$$c_ref>\n";
    }
}

sub Convert_From_C {
    # Two arguments?
    if(2 != scalar(@_)) {
        print STDERR 'Invalid number of arguments. ' . (caller(0))[3] . 'takes two arguments.' . "\n";
    }
    # Fetch arguments.
    my $f_ref = shift;
    my $c_ref = shift;
    # Ensure given temperature is a valid number.
    if($$c_ref =~ /^[-]?[\d]+(\.[\d]+)?$/) {
        # Finally perform the temperature conversion.
        $$f_ref = (9 / 5) * $$c_ref + 32;
    } else {
        print STDERR 'Invalid argument(s). ' . (caller(0))[3] . ' takes only numbers as arguments.' . "\n";
        print STDERR "args: <$$f_ref>,<$$c_ref>\n";
    }
}

################################################################################
# TEMPLATES
################################################################################
