#! /usr/bin/perl
# play with push, unshift, join, slices

my @array1 = qw(Original Authentic);
my $fusion = "";

push @array1, ("Apocalypse", "Omega");
unshift @array1, ("Alpha", "Genesis");
$fusion = join('***', @array1);

print "\nPrinting \@array1 using foreach:\n";
foreach $_ (@array1) {
	print "$_\n";
}
print "\n\$array1[0]: $array1[0]\n";
print "\@array1: @array1\n";
print "\@array1[0, 5]: @array1[0, 5]\n";
print "\$fusion: $fusion\n\n";
