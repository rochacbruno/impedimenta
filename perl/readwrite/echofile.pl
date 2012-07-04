#! /usr/bin/perl
#
# Open a file. Echo that file. Close that file.
#Provide error handling capacities.

#$FILEHANDLE = "";
$lineOfText = "";

#if (-e './testfile.txt') {
	open (FILEHANDLE, '<./testfile.txt') or die ("Error opening file:\n$!");
#} 
while ($lineOfText = <FILEHANDLE>) {			# Note that each $lineOfText includes the \n at its end...
	print "$lineOfText";				# ...NOT the beginning of the next line.
}
print "Script did not end execution at \"die\".\n";

close FILEHANDLE;
