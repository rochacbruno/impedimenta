#! /usr/bin/perl
#
# Testing various regular expressions and their metacharcters.

$testString = "Test string present.\nTest string, line two, present.";

if ($testString =~ /str..g/) {
	print "Match 1 found.\n";
} else {
	print "Match 1 not found.\n";
}
if ($testString =~ /t..tring/) {
	print "Match 2 found.\n";
} else {
	print "Match 2 not found.\n";
}
