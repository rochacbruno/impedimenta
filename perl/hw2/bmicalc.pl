#! /usr/bin/perl
# Name:		Jeremy Audet
# Date Started: 01/24/2010
# Purpose:	User inputs height and weight, in either imperial or metric format. Program calculates and displays BMI.
# Other: 	n/a
#
# Pseudocode: main
# tell user that program takes height and weight, and calculates a BMI;
# while user has not chosen to exit,
#	ask user to choose whether to use metric system, use imperial system, or exit;
#	prompt user for input;
#	while input is not "1", "2", or "3",		# referring to metric, imperial, and exit, respectively
#		inform user that input should be "1", "2", or "3";
#		prompt user for input;
#	if input is 1,
#		call metric_bmi_calc;
#	elsif input is 2,
#		call imperial_bmi_calc;
#	else,
#		continue;
# END;
#
# Pseudocode: metric_bmi_calc
# ask user to enter their weight, in kg;
# prompt user for input;
# while input is greater than 300 kg or less than 10 kg,
#	ask user to enter weight between 10-300 kg;
#	prompt user for input;
# ask user to input height, in m;
# prompt user for input;
# while input is greater than 3 m or less than 0.5m,
#	ask user to enter height between 0.5-3 m;
#	prompt user for input;
# use height and weight to calculate bmi;
# print out bmi;
# END;
#
# Pseudocode: imperial_bmi_calc
# similar to metric_bmi_calc.
#
# Pseudocode: menu
# print out a menu that looks like this...
# 1. Metric
# 2. Imperial
# 3. Exit
# END;

my $answer = 0;				# initialized to 0, so that the loop will work correctly on first run

print "This program takes height and weight, in either metric or imperial format, and\n";
print "calculates BMI.\n";
while($answer != 3)			# continues to loop, as long as user has not chosen to exit
{
	menu();
	chomp($answer = <STDIN>);
	while($answer != 1 && $answer != 2 && $answer != 3)	# make sure input is valid
	{		
		print "Answer must be 1, 2, or 3\n";
		menu();
		chomp($answer = <STDIN>);
	}
	if($answer == 1) {
		metric_bmi_calc();
	} elsif($answer == 2) {
		imperial_bmi_calc();
	} else {
		;					# if input is 3, this statement is necessary
	}
}

sub menu
{
	print "\n1. Metric\n";
	print "2. Imperial\n";
	print "3. Exit\n";
}

sub metric_bmi_calc
{
	my $weight;
	my $height;
	my $bmi;

	print "Please enter your weight, in kilograms: ";
	chomp($weight = <STDIN>);
	while($weight < 10 || $weight > 300)
	{
		print "Weight must be between 10 and 300 kg\n";
		print "Please enter your weight, in kilograms: ";
		chomp($weight = <STDIN>);
	}
	print "Please enter your height, in meters: ";
	chomp($height = <STDIN>);
	while($height < 0.5 || $height > 3)
	{
		print "Height must be between 0.5 and 3.0 m\n";
		print "Please enter your height, in meters: ";
		chomp($height = <STDIN>);
	}
	$bmi = $weight / ($height * $height);
	printf("BMI: %4.2f\n", $bmi);
}

sub imperial_bmi_calc
{
	my $weight;
	my $height;
	my $bmi;

	print "Please enter your weight, in pounds: ";
	chomp($weight = <STDIN>);
	while($weight < 22 || $weight > 660)
	{
		print "Weight must be between 22 and 660 lb\n";
		print "Please enter your weight, in pounds: ";
		chomp($weight = <STDIN>);
	}
	print "Please enter your height, in inches: ";
	chomp ($height = <STDIN>);
	while($height < 20 || $height > 120)
	{
		print "Height must be between 20 and 120 in\n";
		print "Please enter your height, in inches: ";
		chomp($height = <STDIN>);
	}
	$bmi = ($weight * 703) / ($height * $height);
	printf("BMI: %4.2f\n", $bmi);
}
