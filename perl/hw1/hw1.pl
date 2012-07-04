# Purpose:	a simple program to convert fahrenheit to celsius
# Name:		Jeremy Audet
# Date Started:	01/20/2010
# Other:	n/a

$f_temp;		# Fahrenheit temperature.
$c_temp;		# Celsius temperature.

print "This program takes a temperature in Fahrenheit, and converts it to Celsius.\n";
print "Please enter a temperature: ";
$f_temp = <stdin>;
$c_temp = ($f_temp - 32) * 5 / 9;
printf("Temperature in Celsius:     %.2f\n", $c_temp);
