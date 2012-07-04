#!/usr/bin/perl
use warnings;
use strict;

#-----------------------------------------------------------------------------*\
# Initializations
#-----------------------------------------------------------------------------*/

use constant SCREEN_HEIGHT =>   100;     # used in the clearScreen subroutine
use constant LOWER_LIMIT =>     0;
use constant UPPER_LIMIT =>     100;

my $userGuess = 0;
my $totalUserGuesses = 0;
my $secretNumber = 0;

#-----------------------------------------------------------------------------*\
# Main program
#-----------------------------------------------------------------------------*/
#
# present user with instructions and/or information
# do
#   ask user for number
#   => output results
# while guess is a fail

# srand() is automatically called when rand() is first used in a program
# see: http://perldoc.perl.org/functions/srand.html
#
# By default, rand() will return a number between 0 and 1.
$secretNumber = int rand(UPPER_LIMIT);
print "$secretNumber!!!!\n";
&clearScreen();
print "Welcome to the guess a number game! I'm thinking of a number between " . LOWER_LIMIT . " and " . UPPER_LIMIT . ", inclusive.\n";

do {
    print "Guess: ";
    chomp($userGuess = <STDIN>);
    $totalUserGuesses++;

    if($userGuess > $secretNumber) {
        print "$userGuess is too high. Try again.\n";
    } elsif ($userGuess < $secretNumber) {
        print "$userGuess is too low. Try again.\n";
    } else {
        print "Congrats! You guessed the secret number.\n";
        print "You guessed $userGuess. The actual number is $secretNumber.\n";
        print "You made $totalUserGuesses guesses.\n";
    }
} while ($userGuess != $secretNumber);

#-----------------------------------------------------------------------------*\
# Subroutines
#-----------------------------------------------------------------------------*/
sub clearScreen {
    my $i;

    for($i = 0; $i < SCREEN_HEIGHT; $i++) {
        print "\n";
    }
}
