#! /usr/bin/perl
# Test out different types of declarations.

$index = 5;
@names = ("Jeremy", "Nobuo", "Joel", "Kain");
%balances = ("Jeremy" => 1542, "$names[1]" => 84181, "$names[2]" => "uh-oh");

print "$index\n";
print "$names[0]\n";
print "$balances{Nobuo}\n";
print "$balances{Joel}\n";
