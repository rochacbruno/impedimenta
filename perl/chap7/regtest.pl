#! /usr/bin/perl

$str = "Hello there.";
$result = "";

$result = $str =~ /([a-z]+)\s([a-z]+)/;
print "$&\n";
print "$result\n";
$result = $str =~ /[a-z]\s[a-z]/;
print "$&\n";
print "$result\n";
$result = $str =~ /([a-z]+)\s([a-z]*)/i;
print "$&\n";
print "$result\n";
print "-"x24, "\n";
$result = $str =~ /[a-z]\s[a-z]/;
print "$&\n";
print "$result\n";
$result = $str =~ /[a-z]\s[a-z]/i;
print "$&\n";
print "$result\n";
