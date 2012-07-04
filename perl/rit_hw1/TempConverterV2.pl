#!/usr/bin/perl
use strict;
use warnings;
use Tk;

################################################################################
# DESCRIPTION
#
# Script Name:              TempConverterV2.pl
# Original Creation Date:   Jan 8, 2012
# Original Author:          Jeremy Audet
#
# This script implements a GUI-based temperature converter. It converts between
# fahrenheit, celsius, and Kelvin. This script relies upon Tk library to create
# a GUI.
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
    my $k_temp = 0;

    ####################################
    # Declare Tk objects. 
    # Initialize Tk objects.
    # Define semantics/behaviour of GUI elements.
    ####################################
    my $window              = MainWindow -> new;
    my $f_label             = $window->Label    (-text          => "Degrees F");
    my $f_entry             = $window->Entry    (-textvariable  => \$f_temp);
    my $f_convert_button    = $window->Button   (-text          => "Convert From Fahrenheit",
                                                 -command       => sub {&Convert_From_F(\$f_temp, \$c_temp, \$k_temp)});
    my $c_label             = $window->Label    (-text          => "Degrees C");
    my $c_entry             = $window->Entry    (-textvariable  => \$c_temp);
    my $c_convert_button    = $window->Button   (-text          => "Convert From Celsius",
                                                 -command       => sub {&Convert_From_C(\$f_temp, \$c_temp, \$k_temp)});
    my $quit_button         = $window->Button   (-text          => "Quit",
                                                 -command       => sub {$window->destroy});
    my $k_label             = $window->Label    (-text          => "Degrees K");
    my $k_entry             = $window->Entry    (-textvariable  => \$k_temp);
    my $k_convert_button    = $window->Button   (-text          => "Convert From Kelvin",
                                                 -command       => sub {&Convert_From_K(\$f_temp, \$c_temp, \$k_temp)});
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
    $k_label                -> grid(-row        => 3,
                                    -column     => 1);
    $k_entry                -> grid(-row        => 3,
                                    -column     => 2);
    $k_convert_button       -> grid(-row        => 3,
                                    -column     => 3);
    # Row 4 Settings ###################
    $quit_button            -> grid(-row        => 4,
                                    -column     => 1,
                                    -columnspan => 3);
}

# args: fahrenheit temp, celsius temp, kelvin temp
sub Convert_From_F {
    # Three arguments?
    if(3 != scalar(@_)) {
        print STDERR 'Invalid number of arguments. ' . (caller(0))[3] . 'takes three arguments.' . "\n";
    }
    # Fetch arguments.
    my $f_ref = shift;
    my $c_ref = shift;
    my $k_ref = shift;
    # Ensure given temperature is a valid number.
    if($$f_ref =~ /^[-]?[\d]+(\.[\d]+)?$/) {
        # Finally perform the temperature conversion.
        $$c_ref = ($$f_ref- 32.0) * (5.0/9.0);
        $$k_ref = $$c_ref + 273.15;
    } else {
        print STDERR 'Invalid argument(s). ' . (caller(0))[3] . ' takes only numbers as arguments.' . "\n";
        print STDERR "args: <$$f_ref>,<$$c_ref>\n";
    }
}

# args: fahrenheit temp, celsius temp, kelvin temp
sub Convert_From_C {
    # Three arguments?
    if(3 != scalar(@_)) {
        print STDERR 'Invalid number of arguments. ' . (caller(0))[3] . 'takes three arguments.' . "\n";
    }
    # Fetch arguments.
    my $f_ref = shift;
    my $c_ref = shift;
    my $k_ref = shift;
    # Ensure given temperature is a valid number.
    if($$c_ref =~ /^[-]?[\d]+(\.[\d]+)?$/) {
        # Finally perform the temperature conversion.
        $$f_ref = (9 / 5) * $$c_ref + 32;
        $$k_ref = $$c_ref + 273.15;
    } else {
        print STDERR 'Invalid argument(s). ' . (caller(0))[3] . ' takes only numbers as arguments.' . "\n";
        print STDERR "args: <$$f_ref>,<$$c_ref>\n";
    }
}

# args: fahrenheit temp, celsius temp, kelvin temp
sub Convert_From_K {
    # Three arguments?
    if(3 != scalar(@_)) {
        print STDERR 'Invalid number of arguments. ' . (caller(0))[3] . 'takes three arguments.' . "\n";
    }
    # Fetch arguments.
    my $f_ref = shift;
    my $c_ref = shift;
    my $k_ref = shift;
    # Ensure given temperature is a valid number.
    if($$k_ref =~ /^[-]?[\d]+(\.[\d]+)?$/) {
        # Finally perform the temperature conversion.
        $$c_ref = $$k_ref - 273.15;
        $$f_ref = (9 / 5) * $$c_ref + 32;
    } else {
        print STDERR 'Invalid argument(s). ' . (caller(0))[3] . ' takes only numbers as arguments.' . "\n";
        print STDERR "args: <$$f_ref>,<$$c_ref>\n";
    }
}

################################################################################
# TEMPLATES
################################################################################
