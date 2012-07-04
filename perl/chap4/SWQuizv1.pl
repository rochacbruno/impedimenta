#! /usr/bin/perl
#
# Jeremy Audet
# The Star Wars Quiz!

$reply = "";
$continueQuiz = 0;
$numCorrect = 0;
$numIncorrect = 0;
$numQuestions = 0;
@answers = ();
@ranks = ('Beginner', 'Padawan', 'Jedi', 'Jedi Knight', 'Jedi Master', 'Jedi Master and Council Member');

while ($continueQuiz == 0) {
	clear_screen();
	print " ";
	print "W e l c o m e   t o   t h e   S T A R   W A R S   Q u i z!";
	print "\n"x12;
	print "[Start] [Quit] [Help]\n\n";
	print "Enter Command: ";

	chomp ($reply = <STDIN>);
	if ((lc $reply) eq "start") {
		$continueQuiz = 1;
	} elsif ((lc $reply) eq "quit") {
		clear_screen();
		print "Very well, may the force be with you!\n\n\n\n";
		print "Press Enter to Continue: ";

		$reply = <STDIN>;
		clear_screen();
		exit;
	} elsif ((lc $reply) eq "help") {
		clear_screen();
		print "Star Wars Quiz Instructions:\n\n";
		print "Type Start to begin the game or type Quit to exit. To play,\n";
		print "answer each question that is presented by typing the\n";
		print "letter that matches the correct answer for each question. Once\n";
		print "all questions have been answered, you will receive your Jedi\n";
		print "rank.\n\n\n\n";
		print "Press Enter to Continue: ";

		chomp ($reply = <STDIN>);
	}
}

#Begin Quiz Questions---------------------------------------------------------#
do {
	clear_screen();
	print "Question 1: Obi-Wan Kenobi's Jedi master in Star Wars was:\n\n";
	print "A) Qui-Gon Jinn\n";
	print "B) Yoda\n";
	print "C) Mace Windu\n";
	print "D) None of the above\n\n\n\n";
	print "Answer: ";

	chomp ($reply = <STDIN>);
} while ((lc $reply) ne "a" && (lc $reply) ne "b" && (lc $reply) ne "c" && (lc $reply) ne "d");
if ((lc $reply) eq "a") {
	@answers[0] = "correct";
} else {
	@answers[0] = "incorrect";
}

do {
	clear_screen();
	print "Question 2: The arch enemies of the Jedi are known as the:\n\n";
	print "A) Sith\n";
	print "B) Dark Lords\n";
	print "C) Deviators\n";
	print "D) None of the above\n\n\n\n";
	print "Answer: ";

	chomp ($reply = <STDIN>);
} while ((lc $reply) ne "a" && (lc $reply) ne "b" && (lc $reply) ne "c" && (lc $reply) ne "d");
if ((lc $reply) eq "a") {
	@answers[1] = "correct";
} else {
	@answers[1] = "incorrect";
}

do {
	clear_screen();
	print "Question 3: Who did Yoda fight at the end of Star Wars II?\n\n";
	print "A) Mace Windu\n";
	print "B) Palpatine\n";
	print "C) Count Dooku\n";
	print "D) None of the above\n\n\n\n";
	print "Answer: ";

	chomp ($reply = <STDIN>);
} while ((lc $reply) ne "a" && (lc $reply) ne "b" && (lc $reply) ne "c" && (lc $reply) ne "d");
if ((lc $reply) eq "c") {
	@answers[2] = "correct";
} else {
	@answers[2] = "incorrect";
}

do {
	clear_screen();
	print "Question 4: Who killed Mace Windu in Star Wars III?\n\n";
	print "A) Palpatine\n";
	print "B) The bounty hunter\n";
	print "C) Count Dooku\n";
	print "D) None of the above\n\n\n\n";
	print "Answer: ";

	chomp ($reply = <STDIN>);
} while ((lc $reply) ne "a" && (lc $reply) ne "b" && (lc $reply) ne "c" && (lc $reply) ne "d");
if ((lc $reply) eq "a") {
	@answers[3] = "correct";
} else {
	@answers[3] = "incorrect";
}

do {
	clear_screen();
	print "Question 5: Who uttered the phrase \"Help me Obi-Wan Kenobi, you\n";
	print "are our only hope\" in Star Wars IV?\n\n";
	print "A) Yoda\n";
	print "B) Princess Leia\n";
	print "C) Luke\n";
	print "D) None of the above\n\n\n\n";
	print "Answer: ";

	chomp ($reply = <STDIN>);
} while ((lc $reply) ne "a" && (lc $reply) ne "b" && (lc $reply) ne "c" && (lc $reply) ne "d");
if ((lc $reply) eq "b") {
	@answers[4] = "correct";
} else {
	@answers[4] = "incorrect";
}
#End Quiz Questions-----------------------------------------------------------#

clear_screen();
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

sub clear_screen {
	print "\n"x60;
}
