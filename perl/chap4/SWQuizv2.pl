#! /usr/bin/perl
#
# Jeremy Audet
# New and Improved! The Star Wars Quiz!

#------------------------------------------------------------------------------
# Global Declarations
#------------------------------------------------------------------------------

$repeatProgram = 'yes';
$menuChoice = '';

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------

do {
	clearScreen();
	menu();
	$menuChoice = getValidateInput('Quit', 'Help', 'Start');
	if ($menuChoice eq 'Quit') {
		$repeatProgram = 'no';		# repeatProgram is set to yes unless changed here.
		clearScreen();
		print "Very well. May the Force be with you.\n";
	} elsif ($menuChoice eq 'Help') {
		clearScreen();
		help();
		clearScreen();
	} elsif ($menuChoice eq 'Start') {
		clearScreen();
		quiz();
		clearScreen();
	}
} while ($repeatProgram eq 'yes');

#------------------------------------------------------------------------------
# Sub: menu
#------------------------------------------------------------------------------
sub menu {
	print "W e l c o m e   t o   t h e   S T A R   W A R S   Q u i z!";
	print "\n"x12;
	print "[Start] [Quit] [Help]\n";
	print "> ";
}

#------------------------------------------------------------------------------
# Sub: clearScreen
#------------------------------------------------------------------------------

sub clearScreen {
	print "\n"x80;
}

#------------------------------------------------------------------------------
# Sub: help
#------------------------------------------------------------------------------

sub help {
	print "Star Wars Quiz Instructions:\n\n";
	print "Type Start to begin the game or type Quit to exit. To play,\n";
	print "answer each question that is presented by typing the\n";
	print "letter that matches the correct answer for each question. Once\n";
	print "all questions have been answered, you will receive your Jedi\n";
	print "rank.\n\n\n\n";
	print "> ";

	getValidateInput();
}

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

#------------------------------------------------------------------------------
# Sub: quiz
#------------------------------------------------------------------------------

sub quiz {
	my $reply = '';
	my $numQuestions = 0;
	my $numCorrect = 0;
	my $numIncorrect = 0;
	my @answers = '';
	my @ranks = ('Beginner', 'Padawan', 'Jedi', 'Jedi Knight', 'Jedi Master', 'Jedi Master and Council Member');

	clearScreen();
	print "Question 1: Obi-Wan Kenobi's Jedi master in Star Wars was:\n\n";
	print "A) Qui-Gon Jinn\n";
	print "B) Yoda\n";
	print "C) Mace Windu\n";
	print "D) None of the above\n\n\n\n";
	print "> ";
	$reply = getValidateInput('A', 'B', 'C', 'D');
	if ($reply eq "A") {
		@answers[0] = "correct";
	} else {
		@answers[0] = "incorrect";
	}

	clearScreen();
	print "Question 2: The arch enemies of the Jedi are known as the:\n\n";
	print "A) Sith\n";
	print "B) Dark Lords\n";
	print "C) Deviators\n";
	print "D) None of the above\n\n\n\n";
	print "> ";
	$reply = getValidateInput('A', 'B', 'C', 'D');
	if ($reply eq "A") {
		@answers[1] = "correct";
	} else {
		@answers[1] = "incorrect";
	}

	clearScreen();
	print "Question 3: Who did Yoda fight at the end of Star Wars II?\n\n";
	print "A) Mace Windu\n";
	print "B) Palpatine\n";
	print "C) Count Dooku\n";
	print "D) None of the above\n\n\n\n";
	print "> ";
	$reply = getValidateInput('A', 'B', 'C', 'D');
	if ($reply eq "C") {
		@answers[2] = "correct";
	} else {
		@answers[2] = "incorrect";
	}

	clearScreen();
	print "Question 4: Who killed Mace Windu in Star Wars III?\n\n";
	print "A) Palpatine\n";
	print "B) The bounty hunter\n";
	print "C) Count Dooku\n";
	print "D) None of the above\n\n\n\n";
	print "> ";
	$reply = getValidateInput('A', 'B', 'C', 'D');
	if ($reply eq "A") {
		@answers[3] = "correct";
	} else {
		@answers[3] = "incorrect";
	}

	clearScreen();
	print "Question 5: Who uttered the phrase \"Help me Obi-Wan Kenobi, you\n";
	print "are our only hope\" in Star Wars IV?\n\n";
	print "A) Yoda\n";
	print "B) Princess Leia\n";
	print "C) Luke\n";
	print "D) None of the above\n\n\n\n";
	print "> ";
	$reply = getValidateInput('A', 'B', 'C', 'D');
	if ($reply eq "B") {
		@answers[4] = "correct";
	} else {
		@answers[4] = "incorrect";
	}

	clearScreen();
	print "_"x50;
	print "\n\n                    Score:\n";
	print "_"x50, "\n\n";
	foreach $_ (@answers) {
		$numQuestions++;
		if ($_ eq "correct") {
			$numCorrect++;
		}
		print "Question $numQuestions: $_\n";
	}
	$numIncorrect = $numQuestions - $numCorrect;
	print "\nNumber of correct answers: $numCorrect\n";
	print "Number of incorrect answers: $numIncorrect\n";
	print "Your Jedi rank is: $ranks[$numCorrect]\n";

	print "> ";
	getValidateInput();
}
