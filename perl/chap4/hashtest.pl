#! /usr/bin/perl
#
# Test how hashes can be used with foreach().

%friendsHash = (crazyMan => 'David', trustedMan => 'Mike', theMan => 'Mikey', woMan => 'Autumn');
@friendsArray = %friendsHash;
$key = "";
$arrayValue = "";
$hashValue = "";

foreach $key (keys %friendsHash) {
	print "\$key: $key	";
	print "\$friendsHash{\$key}: $friendsHash{$key}\n";
}
print "\n";
foreach $arrayValue (@friendsArray) {
	print "\$arrayValue: $arrayValue	";
	print "\$friendsArray[\$arrayValue]: $friendsArray[$arrayValue]\n";
}
print "\n";
foreach $hashValue (%friendsHash) {
	print ("\$hashValue: $hashValue\n");
}
