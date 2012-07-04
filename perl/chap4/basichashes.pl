#! /usr/bin/perl
# Test out the basics of hashes.

%hash = (name => 'Jeremy', book => "Perl Programming");
@array = "";
$i = 0;

print "Vanilla Hash:\n";
foreach $_ (keys %hash) {
	print "$hash{$_}\n";
}

%hash = (%hash, thought => 'fooooood', dcpp => 'great');
print "\nHash after being destructively modified:\n";
foreach $_ (keys %hash) {
	print "$hash{$_}\n";
}

$hash{'drink'} = ('tea');
print "\nHash after being non-destructively modified:\n";
foreach $_ (values %hash) {
	print "$_\n";
}

print "\nAgain, but sorted by key value this time:\n";
foreach $_ (sort (keys (%hash))) {
	print "$hash{$_}\n";
}

@array = %hash;
print "\n\@array after being filled with data from \%hash.\n";
foreach $_ (@array) {
	if($i == 0) {
		print "Key: $_	";
		$i++;
	} else {
		print "Value: $_\n";
		$i = 0;
	}
}
