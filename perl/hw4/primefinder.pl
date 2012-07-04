#! /usr/bin/perl
#
# primefinder.pl -- find all the prime numbers up to some int given by the user.
#
# PSEUDOCODE
# Tell user that this is the primefinder program! I find all the primes less than some number you give me;
# do,
#	ask for a number;
#	get input;
#	while input is not valid,
#		get a number;
#
#	check for all primes less than the number given;
#	print out all primes less than the number given;
#
#	ask the user whether they want to repeat or not;
#	get an answer;
# 	while input is not valid,
#		get answer (yes or no);
# while user has not chosen to exit, REPEAT
# 

# SUBS
# IsPositive();
# ListPrimeNumbers();
# IsNumberPrime();
# GetNumInput();

my $repeatProgram = "";		# Should I find more primes after the first run?
my $targetNumber = "";		# Program finds all numbers less than the targetNumber. The number the user give me is the target, I find all primes less than.

print "Hi! I'm the primefinder program! I find all the primes less than some number you give me.\n";
do
{
	print "Please, give me a number between 0 and 10000.\n";
	print "I will find all the primes from zero to that number.\n";
	print "Number please:";
	$targetNumber = GetNumInput();
	#-----Validation
	while(IsPositive($targetNumber) == 0 || $targetNumber > 10000)
	{
		print "\nI'm sorry, but that's not valid input.\n";
		print "Please, give me a number between 0 and 1000.\n";
		print "I will find all the primes from zero to that number.\n";
		print "Number please:";
		$targetNumber = GetNumInput();
	}
	#-----End Validation

	ListPrimeNumbers($targetNumber);

	print "\nWould you like to find some more primes? (yes/no): ";
	chomp($repeatProgram = <STDIN>);
	$repeatProgram eq lc ($repeatProgram);
	#-----Validation
	while ($repeatProgram ne 'yes' && $repeatProgram ne 'no')
	{
		print "\nI'm sorry, but that's not valid input.\n";
		print "Would you like to find some more primes? (yes/no): ";
		chomp($repeatProgram = <STDIN>);
		$repeatProgram eq lc ($repeatProgram);
	}
	#-----End Validation
} while ($repeatProgram eq "yes");

sub IsPositive
{
	my $testNumber = $_[0];

	if ($testNumber < 0)
	{
		return 0;
	}
	else
	{
		return 1;
	}
}

sub ListPrimeNumbers
{
	my $targetNumber2 = $_[0];
	my @primes = ();
	my $mayBePrime = 0;			# This number May Be Prime (or maybe not)

	print "\nThe number you've given me is: $targetNumber2\n";
	for($mayBePrime = 0; $mayBePrime <= $targetNumber2; $mayBePrime++)	# Cycle through all ints less than target, and check whether each is prime
	{
		if (IsNumberPrime($mayBePrime) == 1) {
			push (@primes, $mayBePrime);
		}			
	}
										# all primes found. printing primes now.
	print "Prime numbers between 0 and $targetNumber2:";
	foreach $_ (@primes) {
		print " $_";
	}
	print "\n";
}

sub IsNumberPrime
{
	my $testNumber = $_[0];			# I'm testing $testNumber to see whether it's prime
	my $isNumberPrime = "yes";		# Start by assuming that testNumber is prime!
	my $divisor = 2;			# I'm dividing divisor into testNumber

	if ($testNumber < 2)
	{
		$isNumberPrime = "no";		# If testNumber is less than two, you know it's not prime.
	}					# If testNumber is less than two, the normal tests below will not work.
	else
	{
		for ($divisor = 2; $divisor < $testNumber && $isNumberPrime eq "yes"; $divisor++)	# Continue testing while...
		{				# ...the number is still assumed to be prime, and tests can still be performed.
			if ($testNumber % $divisor == 0)						# is testNumber evenly divisible?...
			{
				$isNumberPrime = "no";							# if so, number is not prime
			}
		}
	}
						# All tests on the testNumber have been performed.
	if ($isNumberPrime eq "yes")
	{
		return 1;
	} 
	else
	{
		return 0;
	}
}

sub GetNumInput
{
	my $input = "";

	chomp($input = <STDIN>);
	$input = int($input);

	return $input;
}
