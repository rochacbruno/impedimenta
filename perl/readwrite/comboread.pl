#! /usr/bin/perl
#
# Get input from user. Then either write or append to a file.

$fileToWrite = "";
$openMode = "read";
$message = "I have visited you.";
$fileText = "";
@contents = ();

print "Name of the file you would like to write to:\n> ";
chomp ($fileToWrite = <STDIN>);
print "Mode to open file?\n";
print "[read] [write] [append] [read+write] [read+append]\n";
print "> ";
$openMode = getValidateInput('read', 'write', 'append', 'read+write', 'read+append');
if ($openMode eq 'read') {
	open (FILEHANDLE, '<', "./$fileToWrite");
} elsif ($openMode eq 'write') {
	open (FILEHANDLE, '>', "./$fileToWrite");
} elsif ($openMode eq 'append') {
	open (FILEHANDLE, '>>', "./$fileToWrite");
} elsif ($openMode eq 'read+write') {
	open (FILEHANDLE, '+>', "./$fileToWrite");
} elsif ($openMode eq 'read+append') {
	open (FILEHANDLE, '+>>', "./$fileToWrite");
} else {
	print "Uh, how to open file? I don't know. Exiting.\n";
	exit;
}

print ("File before modification:\n");
@contents = <FILEHANDLE>;
foreach $text (@contents) {
	print "$text";
}
print FILEHANDLE ("$message\n");
print ("File after modification:\n");
@contents = <FILEHANDLE>;
foreach $text (@contents) {
	print "$text";
}

close FILEHANDLE;

#------------------------------------------------------------------------------
# Sub: getValidateInput
#------------------------------------------------------------------------------

sub getValidateInput {
	my @arguments = @_;
	my $userInput = '';
	my $validInput = '';
	my $validInputCopy = '';

	if (! exists $arguments[0]) {		# If no input choices are passed to sub, just prompt
		$userInput = <STDIN>;	# for user to press Enter. Immediately end sub.
	} else {
		chomp ($userInput = <STDIN>);		# WARNING: User input can be upper/lower case, makes no difference.
		foreach $validInput (@arguments) {	# For each possible answer (passed to sub),
			$validInputCopy = $validInput;	# ...make a copy of the correct answer.
			if (lc $userInput eq lc $validInputCopy) {	# Then check if user input matches correct answer.
				return $validInput;	# If match found, return the correct answer (as passed to the sub),
			}				# rather than, say, user input. This allows sub to behave predictably.
		}					# Sub will ONLY return one of the arguments that has been passed to it.

		while (1) {				# If user gave wrong input, perform the same operations as above.
			print "\n\nInput not valid. Please enter input according to choices given.\n";
			foreach $validInput (@arguments) {	# Only difference is that an error message is displayed.
				print "[$validInput] ";
			}
			print "\n> ";
			chomp ($userInput = <STDIN>);
			foreach $validInput (@arguments) {
				$validInputCopy = $validInput;
				if (lc $userInput eq lc $validInputCopy) {
					return $validInput;
				}	# End if
			}		# End foreach
		}			# End while (1)
	}				# End else
}					# End sub
