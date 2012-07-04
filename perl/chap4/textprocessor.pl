#! /usr/bin/perl
# This is a simple text processing program. It takes user input and spits out 
# some statistics about the input.
#
# OBJECTIVES
# This program reads input until a newline is read.
# It spits out some statistics. I'd like to modify it so it reads until EOF, 
# or some other type of delimiter besides \n.

$input = "yes";
$returnValue = 0;
#SUBS
# WordCount()
# SCount()
# UpperCount()
while($input eq "yes") {
	print "Please enter some input: ";
	chomp($input = <STDIN>);
	print "Thank you. Here are some statistics about your input.\n";
	$returnValue = WordCount($input);
	print "Number of words in input: $returnValue\n";
	$returnValue = SCount($input);
	print "Occurences of the letter 's': $returnValue\n";
	$returnValue = UpperCount($input);
	print "Occurences of upper case letters: $returnValue\n";
	print "\nType in \"yes\" to repeat: ";
	chomp($input = <STDIN>);
}

sub WordCount {
	print "WordCount reporting.\n";
	
	return 3;
}

sub SCount {
	print "SCount reporting.\n";
}

sub UpperCount {
	print "UpperCount reporting.\n";
}
