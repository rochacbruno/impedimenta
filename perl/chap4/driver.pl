#! /usr/bin/perl

print "Calling getValidateInput()\n";
getValidateInput();
print "Calling getValidateInput('One', 'Two')\n";
getValidateInput('One', 'Two');

sub clearScreen {
	print "\n"x20;
	print "CLEAR SCREEN\n";
	print "\n"x20;
}

sub getValidateInput {
	my $userInput = '';
	my $validInput = '';
	my $validInputCopy = '';

	if (! exists $_[0]) {		# If no input choices are passed to sub, just prompt
		$userInput = <STDIN>;	# for user to press Enter. Immediately end sub.
	} else {
		chomp ($userInput = <STDIN>);		# WARNING: User input can be upper/lower case, makes no difference.
		foreach $validInput (@_) {		# For each possible answer (passed to sub),
			$validInputCopy = $validInput;	# ...make a copy of the correct answer.
			if (lc $userInput eq lc $validInputCopy) {	# Then check if user input matches correct answer.
				return $validInput;	# If match found, return the correct answer (as passed to the sub),
			}				# rather than, say, user input. This allows sub to behave predictably.
		}					# Sub will ONLY return one of the arguments that has been passed to it.

		while (1) {				# If user gave wrong input, perform the same operations as above.
			clearScreen();			# Only difference is that an error message is displayed.
			print "\n\nInput not valid. Please enter input according to choices given.\n";
			foreach $validInput (@_) {
				print "[$validInput] ";
			}
			print "\n\nEnter Command: ";
			chomp ($userInput = <STDIN>);
			foreach $validInput (@_) {
				$validInputCopy = $validInput;
				if (lc $userInput eq lc $validInputCopy) {
					return $validInput;
				}	# End if
			}		# End foreach
		}			# End while (1)
	}				# End else
}					# End sub
