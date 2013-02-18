#!/usr/bin/perl
use strict;
use warnings;

# Finds the total number of lines of code in this repository. Only files with
# an extension in `%filetypes` are included in the search.

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

# Recursively find all files from the current directory. For each file, if it
# has a filename extension in `filetypes`, record length of that file.
foreach my $file (`find . -type f`) {
    chomp $file;
    # The leading .* is necessary.
    if(($file =~ m/.*\.(\S+)$/) and exists($filetypes{$1})) {
        my $extension = $1;
        `wc -l "$file"` =~ m/^(\d+).*/;
        $filetypes{$extension} += $1;
    }
}

my $loc = 0;
foreach my $extension (sort(keys(%filetypes))) {
    my $lines = $filetypes{$extension};
    $loc += $lines;
    print "$extension: $lines\n"
}
print "total: $loc\n"
