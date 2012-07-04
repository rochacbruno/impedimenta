#! /usr/bin/perl

$input;

print "Input!\n> ";
chomp ($input = <STDIN>);
while (undef == ($input =~ /^\d{5}$/)) {
	print "Input invalid.\n> ";
	chomp ($input = <STDIN>);
}
