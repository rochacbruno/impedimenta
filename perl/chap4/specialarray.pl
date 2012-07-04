#! /usr/bin/perl
#Testing the $# array prefix.

@array = qw(Zero One Two);

print "Before changing the size of \@array using the \$\# prefix, array is:\n";
foreach $_ (@array) {
	print "*$_\n";
}
$#array = 3;		# The last element of the array is now referenced using 3.
print "\nAfter changing the size of \@array using the \$\# prefix, array is:\n";
foreach $_ (@array) {
	print "*$_\n";
}
$array[$#array] = "Three";
print "\nAfter changing the value \@array using the \$\# prefix, array is:\n";
foreach $_ (@array) {
	print "*$_\n";
}
