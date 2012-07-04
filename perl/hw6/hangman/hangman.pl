#! /usr/bin/perl -w
# Name:		Jeremy Audet
# Date Started:	04/14/2010
# Purpose: 	Create a hangman game, including a high score table.
# Other:	Coded for perl lab 6. Game MUST be able to access two file to work correctly. One file functions as a high score table, and the other functions as a dictionary of words.

# PSEUDOCODE
#
# FiLl tHiS In bEfOrE SuBmItTiNg
#     _____
#    |/    |
#    |     |
#    |    (_)
#    |    \|/
#    |     |
#    |    / \
#    |
# ___|____
# 
# Word:         $modifiedWord
# Length:       $length letters
# Guesses Left: $triesLeft
#
# Guess:

#------------------------------------------------------------------------------
# SUB DEPENDENCIES
#------------------------------------------------------------------------------

# MAIN
# 	clearScreen
#	getValidateInput
#	hangmanControl
#		clearScreen
#		hangmanGame
#			clearScreen
#			hangmanArt
#			getValidateInput
#		getValidateInput
#		showScores
#	showScores
#		getValidateInput

#------------------------------------------------------------------------------
# GLOBAL VARIABLE DECLARATION
#------------------------------------------------------------------------------

$highScoreLocation = "./scores.txt";	# Where is the high score sheet located?
$wordList = "./dict.txt";		# Where is the list of words that hangman should use?
$guessLimit = 12;			# How many tries shoud the user be given? The ASCII art included in game assumes that the user is given 12 attempts. If this value is modified, you may wish to modify sub hangmanArt().

#------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------

my $menuChoice = "";
do {
	clearScreen();
	print "Welcome to the H A N G M A N   G A M E!\n";
	print "\n"x10;
	print "Please choose an action to take.\n";
	print "\n[Start] [Scores] [Quit]\n> ";
	$menuChoice = getValidateInput('start', 'scores', 'quit');

	if ($menuChoice eq 'start') {
		hangmanControl();
	} elsif ($menuChoice eq 'scores') {
		clearScreen();
		showScores();
	} elsif ($menuChoice eq 'quit') {
		clearScreen();
	} else {
		print "There has been an error calling the appropriate sub from the main menu.\n";
		print "Now exiting.\n";
		exit;
	}
} while ($menuChoice ne "quit");

#------------------------------------------------------------------------------
# SUB clearScreen()
#------------------------------------------------------------------------------

sub clearScreen {
	print "\n"x60;
}

#------------------------------------------------------------------------------
# SUB hangmanControl()
#------------------------------------------------------------------------------

sub hangmanControl {
	my $firstName = "";		# user last name.
	my $lastName = "";		# user first name.
	my $repeatGame = "";		# Does the user want to repeat the game?
	my $wins = 0;			# user wins
	my $losses = 0;			# user losses.
	my $i = 0;			# Temp variable, holds numbers.
	my @highScoreTable = ();	# Holds a copy of the high score table.
	my $temp = "0";			# Temporary variable. Holds both numbers and strings.
	my $newHighScore = "no";	# Has a new high score been found?

	clearScreen();
	print "Please enter your first name.\n> ";
	chomp ($firstName = <STDIN>);
	print "Please enter your last name.\n> ";
	chomp ($lastName = <STDIN>);

	# start hangman game, begin incrementing win/loss counters
	#------------------------------------------------------------------------------
	do {
		clearScreen();
		if (hangmanGame() eq "win") {	# Call the actual hangman quiz. After each quiz attempt, 
			$wins++;		# increment either the $wins or $losses counter, and then ask the user
		} else {
			$losses++;
		}
		print "Would you like to play again?\n";
		print "[yes] [no]\n> ";
		$repeatGame = getValidateInput("yes", "no");
	} while ($repeatGame eq "yes");		# Play the game again if the user has chosen to.
	#------------------------------------------------------------------------------
	# end hangman game, stop incrementing win/loss counters

	# After playing the game, check the high score tables.
	#------------------------------------------------------------------------------
	if (-e "$highScoreLocation") {							# if the high score table exists, 
		open (FILEHANDLE, '<', "$highScoreLocation") or die ("Error: $!\n");	# open it using FILEHANDLE
		@highScoreTable = <FILEHANDLE>;						# copy it into @highScoreTable
		close FILEHANDLE;							# close the file
		# Keep examining entries in @highScoreTable until user score is a high score or the end of the table is found
		while ($i < scalar(@highScoreTable) && $newHighScore eq "no") {
			if ($highScoreTable[$i] =~ /\d* wins (\d*) losses$/) {		# $ comes before the \n
				if ($losses <= $1) {					# if a high score has been found,
					$newHighScore = "yes";				# say so and exit the loop.
				}
				$i++;	# use $i to keep track of where you are in the high score table.
			} else {
				print "High score table is not formatted correctly. Hangman can replace current high\n";
				print "score table with a properly formatted table. WARNING: operation will destroy\n";
				print "current high score table. Continue?\n";
				print "[yes] [no]\n> ";
				$temp = getValidateInput("yes", "no");
				if ($temp eq "yes") {
					open (BACKUP, '<', "./.backupscores.txt") or die ("Error: $!\n");
					open (FILEHANDLE, '>', "$highScoreLocation") or die ("Error: $!\n");
					@highScoreTable = <BACKUP>;
					foreach $temp (@highScoreTable) {
						print FILEHANDLE "$temp";
					}
					close BACKUP;
					close FILEHANDLE;
					print "Hangman has replaced the corrupted current high score table with a properly\n";
					print "formatted table. Restart game to play again. Exiting.\n> ";
					getValidateInput();
					exit;
				} else {
					print "Program exiting to avoid errors. Press any key to continue.\n> ";
					getValidateInput();
					exit;
				}
			}
		}
		$temp = --$i;	# If a high score has been found, you need to store the right value (undo the $i++ in the loop.)

		clearScreen();
		if ($newHighScore eq "yes") {		# ex: Assume there are 10 elements in $highScoreTable, labeled 0 through 9.
			print "Congratulations $firstName, you have a high score!\n";
			$i = scalar(@highScoreTable);	# $i = 10
			$i--;				# $i = 9
			while ($temp <= $i) {		# while 2 is less than or equal to $i
				$highScoreTable[$i] = $highScoreTable[$i - 1];	# copy 8 into 9, 7 into 8, etc.
				$i--;			# Copy 2 into 3. But do NOT copy 1 into 2.
			}				# copy in new high score. (next line)
			$highScoreTable[$temp] = "$firstName $lastName $wins wins $losses losses\n";

			open (FILEHANDLE, '>', "$highScoreLocation") or die ("Error: $!\n");	# Open high score table.
			foreach $temp (@highScoreTable) {	# You know that the file exists; only give error if file cannot be
				print FILEHANDLE "$temp";	# written to. Copy new high score table in, one line at a time.
			}
			close FILEHANDLE;			# close high score table.
		}
	} else {
		print "File \"$highScoreLocation\" not found. Exiting.\n";
		exit;
	}
	#------------------------------------------------------------------------------
	# done checking high score tables. If user has high score, program notifies user (20 lines up)
	showScores();
}

#------------------------------------------------------------------------------
# SUB showScores()
#------------------------------------------------------------------------------

sub showScores {
	my @copyOfFile = ();
	my $score = "";

	if (-e "$highScoreLocation") {
		open (FILEHANDLE, '<', "$highScoreLocation") or die ("Error: $!\n");
		@copyOfFile = <FILEHANDLE>;
		print "Current high scores:\n\n";
		foreach $score (@copyOfFile) {
			print "$score";
		}
		close FILEHANDLE;
	} else {
		print "File \"$highScoreLocation\" not found. Exiting.\n";
		exit;
	}

	print "\n> ";
	getValidateInput();

	return 0;
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
		return undef;
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
}					# End sub

#------------------------------------------------------------------------------
# SUB: hangmanGame
#------------------------------------------------------------------------------

sub hangmanGame {
	my @dictionaryCopy = ();	# Holds a copy of the dictionary of words used in hangman.
	my @word = ();		# Holds the original word fetched from the dictionary.
	my $wordScalar = "";	# Word is also needed in scalar form.
	my @wordCopy = ();	# Holds the copy of the word displayed to the user.
	my $wordLength = 0;	# How long is the word?
	my $wordFound = "no";	# Has the word been guessed yet?
	my $guesses = "";	# What letters has the user guessed?
	my @guessesArray = ();	# Guesses are also needed in array form.
	my $badGuesses = 0;	# How many incorrect guesses has the user made?
	my $i = 0;		# Temporary variable used to hold numbers.
	my $temp = "";		# Temporary variable used to hold strings.

	# Get a word from the dictionary
	#------------------------------------------------------------------------------
	if (-e "$wordList") {
		open (FILEHANDLE, '<', "$wordList") or die ("Error: $!\n");
		@dictionaryCopy = <FILEHANDLE>;		# Get the dictionary.
		close FILEHANDLE;
		$i = scalar(@dictionaryCopy);		# How many words are in the dictionary?
		$i = rand($i);				# Get a random number corresponding to one of the words.
		chomp ($temp = $dictionaryCopy[$i]);	# Get a word from the dictionary, and chomp off its newline.
		@word = split (//, $temp);		# Split the word from the dicitonary into letters.
		foreach $temp (@word) {			# Determine how long the word is.
			$wordLength++;
		}
	} else {
		print "File \"$wordList\" not found. Exiting.\n";
		exit;
	}
	#------------------------------------------------------------------------------
	# Done getting a word from the dictionary.

	$i = 0;
	foreach $temp (@word) {		# Cycle through @word, one letter at a time.
		$wordCopy[$i] = "-";	# New word is same length, but is all dashes.
		$i++;			# This new word will be shown to the user before they guess any letters.
	}

	# Show user art, get a valid guess, generate word to show to user, check whether word has been found.
	#------------------------------------------------------------------------------
	do {
		clearScreen();
		hangmanArt($badGuesses);
		print "Word:         @wordCopy\n";
		print "Length:       $wordLength\n";
		print "Guesses:      $guesses\n";
		printf ("Guesses Left: %d\n", $guessLimit - $badGuesses);
		print "\n";
		print "Guess a letter.\n> ";
		chomp ($temp = <STDIN>);
		while (($temp =~ /../) || ($temp =~ /[[$guesses]/) || ($temp !~ /[a-z]/)) {
			if ($temp =~ /../) {			# If the user guesses more than one letter, 
				print "You can only guess a single letter. Try again.\n> ";
				chomp ($temp = <STDIN>);
			} elsif ($temp =~ /[[$guesses]/) {	# If the user guesses a letter they have already guessed,
				print "You have already guessed that letter. Try again.\n> ";
				chomp ($temp = <STDIN>);
			} else {
				print "Guesses must be a lower case letter, a to z. Try again\n> ";
				chomp ($temp = <STDIN>);
			}
		}
		$guesses = "$guesses$temp";

		# Generate a word to show the user on next run, check if user has found the word.
		#------------------------------------------------------------------------------
		$wordFound = "yes";			# Assume that the word has been found.
		$i = 0;					# Will access elements of $wordCopy, starting at $wordCopy[0].
		foreach $temp (@word) {			# Grab one letter in the word at a time. 
			if ($guesses =~ /$temp/i) {	# If that letter is found among the user's guesses,
				$wordCopy[$i] = "$temp";# place that letter into the wordCopy (which will be
			} else {			# displayed to the user). Otherwise...
				$wordCopy[$i] = "-";	# copy over a dash. The user shouldn't know what the letter
				$wordFound = "no";
			}				# is if they haven't guessed that letter yet! Use a dash instead!
			$i++;
		}
		#------------------------------------------------------------------------------
		# Done generating a word, done checking if user has found word.

		# Check whether user has made too many guesses.
		#------------------------------------------------------------------------------
		$badGuesses = 0;			# Assume the user has made no incorrect guesses.
		$wordScalar = join('', @word);		# Word needs to be in scalar form
		@guessesArray = split(//, $guesses);	# Guesses need to be in array form.
		foreach $temp (@guessesArray) {		# Examine one letter/guess at a time.
			if ($wordScalar !~ /$temp/) {	# If the letter the user guessed is not in the word,
				$badGuesses++;		# then you know that the user has made an incorrect guess.
			}
		}
		#------------------------------------------------------------------------------
		# Done checking whether user has made too many guesses.
	} while ($wordFound eq "no" && $badGuesses < $guessLimit);
	#------------------------------------------------------------------------------
	# Done getting guesses, etc.

	if ($wordFound eq "yes") {
		clearScreen();		# if they would like to play again.
		print "Congratulations, you have saved the man!\n\n";
		print "The word was ";
		print @word;				# print the word without any spaces between letters.
		print ".\n\n";
		return "win";
	} elsif ($wordFound eq "no") {
		clearScreen();
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |    \\|/    \n";
		print "    |     |      \n";
		print "    |    / \\    \n";
		print "    |            \n";
		print " ___|____        \n\n";
		print "Unfortunately, the man has died.\n";
		print "The word was ";
		print @word;				# print the word without any spaces between letters.
		print ".\n\n";
		return "loss";
	} else {
		print "Error determining whether user has won game. Exiting.\n";
		getValidateInput();
		exit;
	}
}

#------------------------------------------------------------------------------
# SUB hangmanArt
#------------------------------------------------------------------------------

sub hangmanArt {
	my $i = $_[0];			# $_[0] = $badGuesses

	if ($i == 0) {
		;
	} elsif ($i == 1) {
		print " ___|____        \n\n";
	} elsif ($i == 2) {
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 3) {
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 4) {
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 5) {
		print "     _____       \n";
		print "    |/           \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 6) {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 7) {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 8) {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |     |     \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 9) {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |    \\|     \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 10) {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |    \\|/    \n";
		print "    |            \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} elsif ($i == 11) {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |    \\|/    \n";
		print "    |     |      \n";
		print "    |            \n";
		print "    |            \n";
		print " ___|____        \n\n";
	} else {
		print "     _____       \n";
		print "    |/    |      \n";
		print "    |     |      \n";
		print "    |    (_)     \n";
		print "    |    \\|/    \n";
		print "    |     |      \n";
		print "    |    / \\    \n";
		print "    |            \n";
		print " ___|____        \n\n";
	}
}
