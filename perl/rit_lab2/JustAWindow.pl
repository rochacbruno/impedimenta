#!/usr/bin/perl
use strict;
use warnings;
use Tk;

# Make a main window.
my $window = MainWindow -> new;

# Set window title.
$window -> title("Window Title");

# Display window. Respond to events such as button clicks (you _do_ want to be
# able to close wthis window, right?).
MainLoop;
