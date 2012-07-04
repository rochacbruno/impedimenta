#! /usr/bin/perl
# Make a program that counts the number of words in an input string, using the
# split function. Hmm.

$input = "";
@input = ();
$wordcount = 0;
$repeatLoop = "yes";

do {
	print "Please give me some input. I'll count the number of words present.\n>";
	chomp($input = <STDIN>);
	@input = split(/ /, $input);
	$wordcount = @input;
	print "You have input $wordcount words.\n";
	print "Your input was: \"$input\"\n";
	print "Your input was parsed as shown below:\n";
	foreach $_ (@input) {
		print "($_)\n";
	}

	print "\nWould you like to repeat this program? (yes/no)\n>";
	chomp($repeatLoop = <STDIN>);
	while($repeatLoop ne "yes" && $repeatLoop ne "no") {
		print "Invalid input. Acceptable input is \"yes\" and \"no\".\n";
		print "Would you like to repeat this program? (yes/no)\n>";
		chomp($repeatLoop = <STDIN>);
	}
	print "\n";
} while ($repeatLoop eq "yes");
