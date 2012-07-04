#!/usr/bin/perl
use strict;
use warnings;

my $loc = 0;        # lines of code
my @files = ();     # the list of files found
my %filetypes = (   # files with any other extension will be ignored
    adb     => 0,   # Ada body
    ads     => 0,   # Ada specification (header)
    asm     => 0,   # assembly
    c       => 0,   # c
    cc      => 0,   # C++
    cpp     => 0,   # C++
    h       => 0,   # C and C++ headers
    java    => 0,   # Java
    pde     => 0,   # arduino
    pl      => 0,   # Perl
    py      => 0,   # Python
    sh      => 0,   # shell
);

# find files and check for filename extension matches
foreach my $file (`find . -type f`) {
    chomp $file;
    if(($file =~ m/.*\.(\S+)$/) and exists($filetypes{$1})) {
        `wc "$file"` =~ m/^\s*(\d+)/; # first column of wc output is lines in file
#        print "$1\n";
        $loc += $1;
    }
}
print "TOTAL: $loc\n";
