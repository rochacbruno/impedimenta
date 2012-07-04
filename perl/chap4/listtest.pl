#! /usr/bin/perl
# Make a simple script that tests using lists and qw().

my @numbers = qw(1 1 2 3 5);
my @names = qw(Alex "Charles Brady" Ha!);
my @lulz = ("wired", "tired", "expired");
my ($x, $y, $z) = ("Nina", "Pinta", "Santa Maria");
my ($a, $b, $c) = qw(Program is done.);

foreach $_ (@numbers) 
{
	print "\@numbers: $_\n";
}
foreach $_ (@names) 
{
	print "\@names: $_\n";
}
foreach $_ (@lulz) 
{
	print "\@lulz: $_\n";
}
print "\$x: $x\n";
print "\$y: $y\n";
print "\$z: $z\n";
print "\$a: $a\n";
print "\$b: $b\n";
print "\$c: $c\n";
