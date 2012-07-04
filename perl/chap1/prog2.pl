#! /usr/bin/perl -w
# Jeremy Audet
# prog2 -l -- a simple-minded program that tells a joke.
# Here's a quick rundown of the steps.
#
# ask user if they want to hear a joke;
# prompt user for input;
# while input is something other than "yes", 
#	prompt user for input;
# print out first line of joke, and ask user for input;
# prompt user for input;
# if answer is wrong,
#	tell the user they are wrong;
# otherwise,
#	congratulate  user on correct answer;
# END;

$reply = '';

clear_screen();
while ($reply ne 'yes') {
	print 'Would you like to hear a joke? (yes or no): ';
	chomp($reply = <STDIN>);
	if($reply ne 'yes') {
		print "Perhaps you misunderstood...\n";	}
}
clear_screen();
print "What disappears the moment you say its name?\n";
chomp($reply = <STDIN>);
if($reply ne 'silence')	{
	print "Sorry. Wrong answer. Think about it and please try again.\n"; }
else {
	print "Correct!\n"; }

sub clear_screen {
	$i;

	for($i = 0; $i < 25; $i++) {
		print "\n"; }
}
