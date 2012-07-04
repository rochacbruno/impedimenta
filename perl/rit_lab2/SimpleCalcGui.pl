#!/usr/bin/perl -w
use strict;
use warnings;
use Tk;
#use diagnostics;

#============================================================================-*\
# Description
#============================================================================-*/
#
# This program is a gui-fied version of the SimpleCalc.pl program.
# It simply multiplies two numbers together, and outputs the result.
#
# The GUI interface for this program can be described using the following grid
# of widgets:
#
#       1                   2
#
# 1     $headline_label     (columnspan)
# 2     $price_label        $price_entry
# 3     $quantity_label     $quantity_entry
# 4     $compute_button     $result_entry

#============================================================================-*\
# Global Declarations
#============================================================================-*/

#============================================================================-*\
# Subroutines
#============================================================================-*/

sub Multiply {
    # These are useful for debugging.
    # print "number of &Multiply params: " . scalar(@_) . "\n";
    # print "list of &Multiply params: @_\n";

    # Check to make sure there is an appropriate number of arguments.
    if(2 != scalar(@_)) {
        print STDERR "Invalid number of arguments. Multiply() takes two arguments.\n";
        return "Invalid number of arguments.";
    }

    # Fetch the arguments.
    my ($val0, $val1) = @_;

    # Check to ensure that both arguments are valid numbers.
    if(($val0 =~ /^\d+(\.\d+)?$/) and ($val1 =~ /^\d+(\.\d+)?$/)) {
        # \d    digit
        # \.    literal period
        # +     match must appear one or more times
        # ?     match must appear zero or one times
        # ()    group
        return ($val0 * $val1);
    } else {
        print STDERR "Invalid argument types. Multiply() takes numbers as arguments.\n";
        return "Invalid argument types.";
    }
}

sub ConstructGui {
    # Create and initialize normal perl variables.
    my $price           = 0;
    my $quantity        = 0;
    my $result          = "0";

    # Create Tk objects, and call their constructors. Note the usage of \$price
    # rather than $price. \$price is a pointer to $price.
    my $window          = MainWindow -> new;
    my $compute_button  = $window -> Button (-text          => "Calculate",
                                             -command       => sub {$result = &Multiply($price, $quantity)});
    my $price_entry     = $window -> Entry  (-textvariable  => \$price);
    my $quantity_entry  = $window -> Entry  (-textvariable  => \$quantity);
    my $result_entry    = $window -> Entry  (-textvariable  => \$result);
    my $headline_label  = $window -> Label  (-text          => "Point of Sale Calculator");
    my $price_label     = $window -> Label  (-text          => "Price");
    my $quantity_label  = $window -> Label  (-text          => "Quantity");

    # Set properties of various Tk objects.
    $window             -> title("SimpleCalc Gui");
    # Row 1
    $headline_label     -> grid(-row        => 1,
                                -column     => 1,
                                -columnspan => 2);
    # Row 2
    $price_label        -> grid(-row        => 2,
                                -column     => 1);
    $price_entry        -> grid(-row        => 2,
                                -column     => 2);
    # Row 3
    $quantity_label     -> grid(-row        => 3,
                                -column     => 1);
    $quantity_entry     -> grid(-row        => 3,
                                -column     => 2);
    # Row 4
    $compute_button     -> grid(-row        => 4,
                                -column     => 1);
    $result_entry       -> grid(-row        => 4,
                                -column     => 2);
}

#============================================================================-*\
# Main
#============================================================================-*/

# Display window. Allows window to respond to events such as button clicks.
ConstructGui();
MainLoop();
