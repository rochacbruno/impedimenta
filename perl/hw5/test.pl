#! /usr/bin/perl

$str = "The year is 200.";
$pattern = "The year is 200[.9]";
$result = "";

$result = $str =~ /$pattern/;
if ($result)
{
	print "Pattern found. The result is $result \n";
}
else
{
	print "Pattern not found. The result is $result \n";
}
