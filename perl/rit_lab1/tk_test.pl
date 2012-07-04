#!/usr/bin/perl
use strict;
use warnings;
use Tk;

my $window = MainWindow->new;
my $drawing = $window->Canvas(-width => 400, -height => 300, -background => "white") -> pack;

$window -> title("Tk Demo");
$window -> Label(-text => "This is a chunk of descriptive text") -> pack;
$drawing -> createOval      (100, 50, 300, 250, -fill => "black");
$drawing -> createRectangle (150, 100, 250, 200, -fill => "white");
$drawing -> createText      (200, 275, -text => "Some text on my drawing!", -anchor => "center");

MainLoop;
