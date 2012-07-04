#! /usr/bin/perl
# Test out some functions for playing with arrays.

@array = qw(3 1 4 Nick Mark Naw 5 naw);

print "Vanilla array:\n";
print "@array\n";

@array = reverse (@array);
print "\nReversed array:\n";
print "@array\n";

@array = sort {$a <=> $b} (@array);
print "\nArray sorted numerically low to high:\n";
print "@array\n";

@array = sort {$b <=> $a} (@array);
print "\nArray sorted numerically high to low:\n";
print "@array\n";
print "$#array + 1 elements present.\n";

@array = sort (@array);
print "\nArray sorted using ASCII values:\n";
print "@array\n";
$num = @array;
print "$num elements present.\n";

undef ($array[2]);
print "\nArray after using undef() on \$array[2]:\n";
print "@array\n";
printf ("%d elements present.\n", $#array + 1);

delete ($array[4]);
print "\nArray after using delete() on \$array[4]:\n";
print "@array\n";
printf ("%d elements present.\n", $#array + 1);
