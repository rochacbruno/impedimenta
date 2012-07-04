#! /usr/bin/perl -w

# Use modules that I have created.

use Random_no;
use Return_arg;
use Double_arg;
$i = 0;

print "Module Random_no\n";
$i = &Random_no::getRandomNumber();
print "Random number: $i\n";
print "Version number: $Random_no::VERSION\n\n";

print "Module Return_arg\n";
print "Argument passed: $i\n";
$i = &Return_arg::returnArg($i);
print "Argument returned: $i\n";
print "Version number: $Return_arg::VERSION\n\n";

print "Module Double_arg\n";
print "Argument passed: $i\n";
$i = &Double_arg::doubleArg($i);
print "Argument returned: $i\n";
print "Version number: $Double_arg::VERSION\n";
