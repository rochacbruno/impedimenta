#! /usr/bin/perl
# Here's some experiments with arrays.

my @array0 = ();
my @array1 = ("Piano", "Harp", "Flute");
my @array2 = qw(Bible Rasselas Conduct);
my @array3 = @array1;
my @array4 = (@array1, @array2);
my @array5 = (@array1, qw(Listen Think Speak));

foreach $_ (@array0) {
	print "\@array0: $_\n";
}
foreach $_ (@array1) {
	print "\@array1: $_\n";
}
foreach $_ (@array2) {
	print "\@array2: $_\n";
}
foreach $_ (@array3) {
	print "\@array3: $_\n";
}
foreach $_ (@array4) {
	print "\@array4: $_\n";
}
foreach $_ (@array5) {
	print "\@array5: $_\n";
}
