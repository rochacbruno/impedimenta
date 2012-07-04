#!/usr/bin/perl
use strict;
use warnings;
use Cwd;
use Readonly;

# global vars
Readonly::Scalar my $LEN_INDEX => 6;
my $get_len = 0;
my $filename = '';

# get argument
unless(1 == @ARGV) {
    die "usage: $0 /path/to/filename.txt\n";
}
$filename = shift(@ARGV);
unless($filename = Cwd::abs_path($filename)) {
    die "given path to file not valid\n";
}

# open file, start reading through line-by-line and spitting out lengths
open(FILE, $filename) or die("Could not open file $filename: $!\n");
while(<FILE>) {
    if($get_len) {
        $get_len = 0;
        print("" . (split(/\s+/))[$LEN_INDEX] . "\n");
    }
    if(/^No\. /) {
        $get_len = 1;
    }
}
close(FILE) or die("Could not close file $filename: $!\n");
