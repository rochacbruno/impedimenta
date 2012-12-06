#!/usr/bin/perl
use strict;
use warnings;

# Finds the total number of lines of code in this repository. Only files with
# an extension in `%filetypes` are included in the search.

my $loc = 0;        # lines of code
my @files = ();     # the list of files found
my %filetypes = (   # files with any other extension will be ignored
    adb     => 0,   # Ada body
    ads     => 0,   # Ada specification (header)
    asm     => 0,   # assembly
    c       => 0,   # c
    cc      => 0,   # C++
    cpp     => 0,   # C++
    cu      => 0,   # CUDA
    h       => 0,   # C and C++ headers
    java    => 0,   # Java
    scala   => 0,   # scala
    pde     => 0,   # arduino
    pl      => 0,   # Perl
    py      => 0,   # Python
    rb      => 0,   # Ruby
    sh      => 0,   # shell
);

foreach my $file (`find . -type f`) {
    chomp $file;
    # If filename has an extension, and that extension is in `filetypes`...
    if(($file =~ m/.*\.(\S+)$/) and exists($filetypes{$1})) {
        # wc output: lines_in_file words_in_file characters_in_file
        # Get number of lines in file.
        `wc "$file"` =~ m/^\s*(\d+)/;
        $loc += $1;
    }
}
print "TOTAL: $loc\n";
