#!/usr/bin/perl
use strict;
use warnings;
use Readonly;

########################################
# Script Name:      hw1_coffee_prices.pl
# Creation Date:    2012/03/22
# Author(s):        Jeremy Audet
#
# Usage: hw1_coffee_prices.pl
# No arguments are accepted.
#
# I've collected the prices on each menu at each cafe on campus. This program
# treats the prices on those menus as samples; one menu is a single sample. This
# program then spits out info about each sample (menu), such as a bar graph.
########################################

Readonly::Scalar my $LEADING_WHITESPACE => 4;
Readonly::Scalar my $BAR_GRAPH_SCALING => 2; # smaller number, longer bar graph

my @artesanos = (
    175, 195, 210, 210, 240, 275,
    260, 285, 310, 175, 195, 210, 
    290, 345, 375, 290, 345, 375,
    340, 395, 415, 210, 240, 275,
    175, 205, 195, 210, 150, 200, 
    345, 375, 375, 405, 365, 405,
    415, 465, 415, 465, 170, 310,
    365, 395
);

my @beanz = (
    169, 189, 205, 169, 169, 169,
    249, 289, 299, 309, 359, 389,
    149, 199, 249, 269, 439, 239, 
    309, 189, 229, 269, 329, 359,
    269, 329, 359, 299, 359, 389,
    299, 359, 389, 299, 359, 389,
    469, 479, 499, 299, 359, 179,
    205, 269, 449, 449, 469, 619
);

my @wallys = (
    125, 175, 185, 325, 365, 425,
    375, 400, 375, 375, 600, 425,
    195, 225, 225, 375, 400, 225,
    275, 400, 200, 225, 250, 200,
    350, 250, 200, 250, 250, 300
);

my @crossroads = (
    165, 280, 195, 280, 330, 315,
    355, 325, 200, 160, 195, 355,
    215, 345, 375, 370, 410, 395,
    255, 190, 215, 375, 235, 375,
    405, 400, 445, 415, 275, 469,
    619, 390, 470, 259, 285, 309,
    299, 325, 349, 315, 370, 400,
    150, 150, 150, 159, 209, 259
);

my @samples = (
    \@artesanos,
    \@beanz, 
    \@wallys,
    \@crossroads
);

my $avg_sample_size = 0;
my $num_classes = 0;
my $class_width = 0;
my $min_price = $samples[0]->[0];
my $max_price = $samples[0]->[0];
my $price_range = 0;

# Find values for:
    # $avg_sample_size
    # $min_price
    # $max_price
    # $num_classes
    # $class_width
    # $price_range
foreach my $sample (@samples) {
    $avg_sample_size += scalar(@$sample);
    foreach my $data_point (@$sample) {
        if($data_point > $max_price) {
            $max_price = $data_point;
        }
        if($data_point < $min_price) {
            $min_price = $data_point;
        }
    }
}
$avg_sample_size /= scalar(@samples);
$num_classes = int(sqrt($avg_sample_size));
$price_range = $max_price - $min_price;
$class_width = int($price_range / $num_classes);

# Display values found above.
print "Average number of data points per sample (items per menu): $avg_sample_size\n";
print "Minimum price      : $min_price cents\n";
print "Maximum price      : $max_price cents\n";
print "Price range        : $price_range cents\n";
print "Width of each class: $class_width cents\n";
print "\n";

print "Artesanos\n";
&print_graph($samples[0], $min_price, $num_classes, $class_width);
print "Beanz\n";
&print_graph($samples[1], $min_price, $num_classes, $class_width);
print "Java Wallys\n";
&print_graph($samples[2], $min_price, $num_classes, $class_width);
print "Crossroads\n";
&print_graph($samples[3], $min_price, $num_classes, $class_width);

# Yeah, I know. This interface is VERY tightly coupled with the main program. But it's better than the current setup.

sub print_graph {
    my $sample_ref  = shift; # array contains a sample of integers
    my $min_val     = shift; # what is the minimum value to be used when printing a graph?
    my $num_classes = shift; # how many bars will be in the resultant bar graph?
    my $class_width = shift; # what is the "width" of each bar in the bar graph?
    my @graph_raw   = ((0) x $num_classes); # how many data points are in each class (bar)?
    my @graph_perc  = ();    # what percentage of the total graph does each bar represent?

    # populate @graph_raw
    foreach my $data_point (@$sample_ref) {
        my $which_class = int(($data_point - $min_val) / $class_width);
        if($which_class < $num_classes) {
            $graph_raw[$which_class]++;
        } else {
            $graph_raw[$num_classes - 1]++;
        }
    }

    # populate @graph_perc
    foreach my $data_points (@graph_raw) {
        push(@graph_perc, (100 * $data_points) / scalar(@$sample_ref));
    }

    print scalar(@$sample_ref) . " items total\n";
    for(my $i = 0; $i < scalar(@graph_raw); $i++) {
        printf("%".$LEADING_WHITESPACE."d items from %d-%d cents (%3d%%) %s\n",
            $graph_raw[$i],
            $min_val + ($class_width * $i),
            $min_val + ($class_width * ($i + 1)) - 1,
            $graph_perc[$i],
            ('=' x sprintf("%3d", ($graph_perc[$i] / $BAR_GRAPH_SCALING)))
        );
    }
    print "\n";
}
