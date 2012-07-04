#! /usr/bin/perl -w
# Name:		Jeremy Audet
# Date Started:	04/07/2010
# Purpose: 	Give the user several methods of examining a text file.
# Other:	Coded for perl lab 5.

#------------------------------------------------------------------------------
# PSEUDOCODE
#------------------------------------------------------------------------------

# Give the user five options for manipulating the input file.
# 1) Display the contents of the input file.
# 2) Allow the user to input a regex. Run the regex against each line of the file. Display each line that matches and what the exact match is.
# 3) Ask the user for a regex to search for and a string to replace with. Probably do a global search. Display each line whe#n a match is found and after the replacement.
# 4) Perform some premade common searches.
# 5) Save any changes back out to the file.
# 6) Quit
# As part of the program, a sub called CountWords must be developed. CountWords takes a scalar as an argument and returns the number of words contained in that scalar. Words are separated by the characters , ; . : ? ! ' " \s

#------------------------------------------------------------------------------
# SUB DEPENDENCIES
#------------------------------------------------------------------------------

#readFile
#main
#	clearScreen
#	getValidateInput
#	displayFile
#		getValidateInput
#	findMatches
#		getValidateInput
#	findAndReplace
#		getValidateInput
#	commonSearches
#		clearScreen
#		getValidateInput
#		commonSearchA
#		commonSearchB
#		commonSearchC
#		countWordsInLines
#			countWords
#		countWordsInFile
#	saveAndReload
#		readFile
#		getValidateInput

#------------------------------------------------------------------------------
# GLOBAL VARIABLE DECLARATION
#------------------------------------------------------------------------------

# Handle for file: FILEHANDLE
$fileToOpen = "./dict.txt";
@copyOfFile = ();

#------------------------------------------------------------------------------
# MAIN MENU
#------------------------------------------------------------------------------

my $menuChoice = "";

readFile();
do {
	clearScreen();
	print "Welcome to the text analyzer. Please choose an action to take.\n";
	print "1) Display file contents\n";
	print "2) Search for expression\n";
	print "3) Search for and replace expression\n";
	print "4) Common searches\n";
	print "5) Save changes\n";
	print "6) Quit\n";
	print "[1] [2] [3] [4] [5] [6]\n";
	print "\n> ";
	$menuChoice = getValidateInput('1', '2', '3', '4', '5', '6');
	clearScreen();

	if ($menuChoice == 1) {
		displayFile();
	} elsif ($menuChoice == 2) {
		findMatches();
	} elsif ($menuChoice == 3) {
		findAndReplace();
	} elsif ($menuChoice == 4) {
		commonSearches();
	} elsif ($menuChoice == 5) {
		saveAndReload();
	} elsif ($menuChoice == 6) {
		;
	} else {
		print "Error choosing correct sub from main menu. Exiting.\n";
		exit;
	}
} while ($menuChoice != 6);

#------------------------------------------------------------------------------
# SUBS LISTED BELOW
#------------------------------------------------------------------------------
# SUB: readFile
#------------------------------------------------------------------------------

sub readFile {
	print "Opening file \"$fileToOpen\"...\n";
	if (-e "$fileToOpen") {
		open (FILEHANDLE, '<', "$fileToOpen") or die ("Error: $!\n");
		print "Copying file \"$fileToOpen\"...\n";
		@copyOfFile = <FILEHANDLE>;
		print "File \"$fileToOpen\" read sucessfully.\n";
		print "Closing file \"$fileToOpen\"...\n";
		close FILEHANDLE;
		print "Success.\n";
	} else {
		print "File \"$fileToOpen\" not found. Exiting.\n";
		exit;
	}

	return 0;
}

#------------------------------------------------------------------------------
# SUB: clearScreen
#------------------------------------------------------------------------------

sub clearScreen {
	print "\n"x60;
}

#------------------------------------------------------------------------------
# SUB: getValidateInput
#------------------------------------------------------------------------------

#	getValidateInput can be passed as many or as few args as needed. Each argument represents a valid input string. For example, say the sub was passed arguments of "Yes" and "No". getValidateInput would prompt the user for input, and only accept a variant of "yes" and "no". This sub is not strict about case. For example, the user could enter "YES" or "nO", and getValidateInput would accept that input.
#	If the user inputs something other than the arguments given, getValidateInput will tell the user that wrong input has been entered. It will also display both a list of valid inputs ([Yes] [No]) and a prompt (> ). Note that getValidateInput will not produce a prompt or display valid input on the first run. It will only display a list of valid inputs and a prompt if the user has entered invalid input. Currently, there is no mechanism for passing custom prompts.
#	getValidateInput will return one of the arguments passed to it, even if user input does not match exactly. For example, if "Yes" and "No" were passed as arguments and "yEs" was input, "Yes" would be returned.

sub getValidateInput {
	my @arguments = @_;
	my $userInput = '';
	my $menuEntry = '';

	if (! exists $arguments[0]) {			# If no input choices are passed to sub, just prompt
		$userInput = <STDIN>;			# for user to press Enter. Immediately end sub.
	} else {
		chomp ($userInput = <STDIN>);		# User input can be upper/lower case, makes no difference.
		foreach $menuEntry (@arguments) {	# For each possible answer that has been passed to the sub,
			if ($menuEntry =~ /^$userInput$/i) {	# Then check if user input matches correct answer.
				return $menuEntry;	# If match found, return appropriate sub argument.
			}				# Do not return exact user input. Again, sub will only return
		}					# one of the arguments given to it (or undef if not match).

		while (1) {				# If user gave wrong input, do above with an error message.
			print "\nInput not valid. Please enter input according to choices given.\n";
			foreach $menuEntry (@arguments) {
				if ($menuEntry eq "\n") {
					print "[(enter)] ";
				} elsif ($menuEntry eq "\t") {
					print "[(tab)] ";
				} else {
					print "[$menuEntry] ";
				}
			}
			print "\n\n> ";
			chomp ($userInput = <STDIN>);

			foreach $menuEntry (@arguments) {
				if ($menuEntry =~ /^$userInput$/i) {
					return $menuEntry;
				}	# End if
			}		# End foreach
		}			# End while (1)
	}				# End else

	return undef;
}

#------------------------------------------------------------------------------
# SUB: displayFile
#------------------------------------------------------------------------------

sub displayFile {
	my $string = "";

	print "-----------------------------------FILE START----------------------------------\n";
	foreach $string (@copyOfFile) {
		print "$string";
	}
	print "------------------------------------FILE END-----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: findMatches
#------------------------------------------------------------------------------

sub findMatches {
	my $regexp = "";
	my $lineOfText = "";
	my $i = 1;

	print "Input an expression to search for. Input can be contents of any regular\n";
	print "expression. For example, \"here\\s\" is valid (omit quotes). \"/here\\s/\" or\n";
	print "\"m<here\\s>i\" is not valid. All matches will be shown.\n";
	print "\n> ";
	chomp ($regexp = <STDIN>);
	print "\n";

	$regexp = "($regexp)";
	print "Search expression: /$regexp/\n";
	print "----------------------------------START RESULTS--------------------------------\n";
	foreach $lineOfText (@copyOfFile) {
		if ($lineOfText =~ /$regexp/) {
			print "$i) $lineOfText";
			print "--> $1\n";
		}
		$i++;
	}
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: findAndReplace
#------------------------------------------------------------------------------

sub findAndReplace {
	my $regexp = "";
	my $replacement = "";
	my $lineOfText = "";
	my $i = 1;

	print "Input an expression to search for. Input can be contents of any regular\n";
	print "expression. For example, \"here\\s\" is valid (omit quotes). \"/here\\s/\" or\n";
	print "\"m<here\\s>i\" is not valid. Only replacements will be shown.\n";
	print "\n> ";
	chomp ($regexp = <STDIN>);
	print "\nInput a string to replace matches with.\n";
	print "\n> ";
	chomp ($replacement = <STDIN>);
	print "\n";

	$regexp = "($regexp)";
	print "Search expression: s/$regexp/$replacement/\n";
	print "----------------------------------START RESULTS--------------------------------\n";
	foreach $lineOfText (@copyOfFile) {
		if ($lineOfText =~ s/$regexp/$replacement/) {
			print "$i) $lineOfText";
			print "Match:       $1\n";
			print "Replacement: $replacement\n";
		}
		$i++;
	}
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: saveAndReload
#------------------------------------------------------------------------------

sub saveAndReload {
	my $temp = "";

	print "Opening file \"$fileToOpen\"...\n";
	if (-e "$fileToOpen") {
		open (FILEHANDLE, '>', "$fileToOpen") or die ("Error: $!\n");
	} else {
		print "File \"$fileToOpen\" not found. Exiting.\n";
		exit;
	}

	print "Writing changes out to \"$fileToOpen\"...\n";
	foreach $temp (@copyOfFile) {
		print FILEHANDLE "$temp";
	}
	print "Changes sucessfully written to \"$fileToOpen\".\n";
	print "Closing file \"$fileToOpen\"...\n";
	close FILEHANDLE;
	print "Success.\n";

	readFile();

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: commonSearches
#------------------------------------------------------------------------------

sub commonSearches {
	my $menuChoice = "";

	do {
		clearScreen();
		print "a) Count number of words ending in 'ing'.\n";
		print "b) Count number of words ending in 'tion'.\n";
		print "c) Count number of words containing two or more of the letter 'e'.\n";
		print "d) Count number of words in each line.\n";
		print "e) Count number of words in entire file.\n";
		print "f) Return to main menu.\n";
		print "[a] [b] [c] [d] [e] [f]\n";
		print "\n> ";
		$menuChoice = getValidateInput('a', 'b', 'c', 'd', 'e', 'f');

		if ($menuChoice eq "a") {
			commonSearchA();
		} elsif ($menuChoice eq "b") {
			commonSearchB();
		} elsif ($menuChoice eq "c") {
			commonSearchC();
		} elsif ($menuChoice eq "d") {
			countWordsInLines();
		} elsif ($menuChoice eq "e") {
			countWordsInFile();
		} elsif ($menuChoice eq "f") {
			;
		} else {
			print "Error choosing which sub to perform. Exiting.\n";
			exit;
		}
	} while ($menuChoice ne 'f');

	return 0;
}

#------------------------------------------------------------------------------
# SUB: commonSearchA
#------------------------------------------------------------------------------

sub commonSearchA {
	my $numOfMatches = 0;
	my $lineOfText = "";
	my $match = "none";
	my $lineNumber = 0;

	print "----------------------------------START RESULTS--------------------------------\n";
	foreach $lineOfText (@copyOfFile) {
		$lineNumber++;
		$numOfMatches = 0;
		while ($lineOfText =~ /(ing\b)/g) {
			$numOfMatches++;
		}
		if ($numOfMatches > 0) {
			$match = "at least one";
			print "$lineNumber) $lineOfText";
			print "--> $numOfMatches matches\n";
		}
	}
	if ($match ne "at least one") {
		print "--> 0 matches\n";
	}
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: commonSearchB
#------------------------------------------------------------------------------

sub commonSearchB {
	my $numOfMatches = 0;
	my $lineOfText = "";
	my $match = "none";
	my $lineNumber = 0;

	print "----------------------------------START RESULTS--------------------------------\n";
	foreach $lineOfText (@copyOfFile) {
		$numOfMatches = 0;
		$lineNumber++;
		while ($lineOfText =~ /(tion\b)/g) {
			$numOfMatches++;
		}
		if ($numOfMatches > 0) {
			$match = "at least one";
			print "$lineNumber) $lineOfText";
			print "--> $numOfMatches matches\n";
		}
	}
	if ($match ne "at least one") {
		print "--> 0 matches\n";
	}
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: commonSearchC
#------------------------------------------------------------------------------

sub commonSearchC {
	my $numOfMatches = 0;
	my $lineOfText = "";
	my $match = "none";
	my $lineNumber = 0;

	print "----------------------------------START RESULTS--------------------------------\n";
	foreach $lineOfText (@copyOfFile) {
		$lineNumber++;
		$numOfMatches = 0;
		while ($lineOfText =~ /(\b\w*e\w*e\w*)/g) {
			$numOfMatches++;
		}
		if ($numOfMatches > 0) {
			$match = "at least one";
			print "$lineNumber) $lineOfText";
			print "--> $numOfMatches matches\n";
		}
	}
	if ($match ne "at least one") {
		print "--> 0 matches\n";
	}
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: countWordsInLines
#------------------------------------------------------------------------------

sub countWordsInLines {
	my $lineOfText = "";
	my $wordCount = 0;
	my $lineNumber = 0;

	print "----------------------------------START RESULTS--------------------------------\n";
	foreach $lineOfText (@copyOfFile) {
		$lineNumber++;
		$wordCount = countWords($lineOfText);
		print "$lineNumber) $lineOfText";
		print "--> $wordCount words\n";
	}
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}

#------------------------------------------------------------------------------
# SUB: countWords
#------------------------------------------------------------------------------

sub countWords {
	my $string = $_[0];
	my $wordCount = 0;

	while ($string =~ /\b\w*\b/g) {
		$wordCount++;
	}

	return $wordCount;
}

#------------------------------------------------------------------------------
# SUB: countWordsInFile
#------------------------------------------------------------------------------

sub countWordsInFile {
	my $lineOfText = "";
	my $wordCount = 0;

	foreach $lineOfText (@copyOfFile) {
		$wordCount = $wordCount + countWords($lineOfText);
	}
	print "----------------------------------START RESULTS--------------------------------\n";
	print "--> $wordCount words in file\n";
	print "-----------------------------------END RESULTS----------------------------------\n";

	print "\n> ";
	getValidateInput();

	return 0;
}
