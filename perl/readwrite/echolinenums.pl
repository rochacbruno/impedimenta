#! /usr/bin/perl
#
# Open a file. Echo that file. Close that file.
#Provide error handling capacities.

#$FILEHANDLE = "";
@linesOfText = ();
$lineOfText = "";
$i = 0;

if (-e './testfile.txt') {
	open (FILEHANDLE, './testfile.txt') or die ("Error opening file:\n$!");
} 
@linesOfText = <FILEHANDLE>;
$i = 1;
foreach $lineOfText (@linesOfText) {
	print "$i) $lineOfText"; 
	++$i;
}

close FILEHANDLE;
