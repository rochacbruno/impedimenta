#!/usr/bin/perl
use strict;
use warnings;

#============================================================================-*\
## DESCRIPTION
#============================================================================-*/

# Formats output of the diruse.exe utility, available on the windows platform.
# Formatted output describes how much space each child directory uses, using
# both percentages and a bar graph. One hash mark (#) represents 2%, two hash
# marks (##) represents 4%, and so on.

## SAMPLE INPUT:
#  Size  (b)   Files  Directory
#
#   54953274    1649  SUB-TOTAL: C:\Documents and Settings
#   82572199    4099  SUB-TOTAL: C:\Perl
#   90421342     640  SUB-TOTAL: C:\Program Files
#     103032       5  SUB-TOTAL: C:\RECYCLER
#  116288461     236  SUB-TOTAL: C:\System Volume Information
# 1318196495    9514  SUB-TOTAL: C:\WINDOWS
# 1654321098   16143  TOTAL

## SAMPLE OUTPUT:
# C:\Documents and Settings    # (3%)
# C:\Perl                      ## (4%)
# C:\Program Files             ## (5%)
# C:\RECYCLER                   (0%)
# C:\System Volume Information ### (7%)
# C:\WINDOWS                   ####################################### (79%)
#
# TOTAL: 1654321098 (b)

## SAMPLE INPUT #2:
# Size (mb)  Files  Directory
# 3.27      1  SUB-TOTAL: C:\USERS\OBSCURE\DOCUMENTS\linktest
# Access Denied      0  C:\USERS\OBSCURE\DOCUMENTS\My Music
# Access Denied      0  C:\USERS\OBSCURE\DOCUMENTS\My Pictures
# Access Denied      0  C:\USERS\OBSCURE\DOCUMENTS\My Videos
# 0.00      0  SUB-TOTAL: C:\USERS\OBSCURE\DOCUMENTS\Reflection
# 0.00      0  SUB-TOTAL: C:\USERS\OBSCURE\DOCUMENTS\SametimeTranscripts
# 5,777.03   1602  SUB-TOTAL: C:\USERS\OBSCURE\DOCUMENTS\SolidWorks Downloads
# 
# 5,780.30   1603  TOTAL

## SAMPLE OUTPUT #2:
# TOTAL: 1654321098 (b)
# C:\USERS\OBSCURE\DOCUMENTS\linktest              (0%)
# C:\USERS\OBSCURE\DOCUMENTS\Reflection            (0%)
# C:\USERS\OBSCURE\DOCUMENTS\SametimeTranscripts   (0%)
# C:\USERS\OBSCURE\DOCUMENTS\SolidWorks Downloads ################################################# (99%)
# 
# TOTAL: 5780.30 (mb)

#============================================================================-*\
# GLOBAL DECLARATIONS
#============================================================================-*/

# Contains each line of output that results from using the diruse.exe command.
my @lines = ();
# A single element/line from the above array.
my $line = '';
# What's the size of the directory listed on each line? One array element for
# each element in @lines that begins with a number.
my @dir_sizes_absolute = ();
# What amount of space does each child directory consume from the parent
# direcotory? Expressed as percentage values.
my @dir_sizes_percent = ();
# Holds the size of an individual directory. Numbers can come in various
# formats, so this scalar allows me to mangle the number a bit before storing
# it in @dir_sizes_absolute.
my $number = 0;
# Do the numbers output by diruse.exe represent bytes, megabytes, or something
# else?
my $number_format = '';
# What's the length of the longest line, in characters? Used for formatting
# output, once directory names and directory sizes have been parsed.
my $max_line_len = 0;
# For counting.
my $i = 0;

#============================================================================-*\
# SUBROUTINES
#============================================================================-*/

#============================================================================-*\
# MAIN
#============================================================================-*/
@lines = <STDIN>;

# Remove all whitespace from the beginning of each line. If a line is composed
# soley of whitespace, this will produce a zero character line.
foreach $line (@lines) {
    $line =~ s/^\s+//;
    chomp($line);
}

# Fetch a string such as (b) or (mb).
$lines[0] =~ /^\S+\s+(\(\S+\))/;
$number_format = $1;

$max_line_len = 0;
for($i = 0; $i < scalar(@lines); $i++) {
    if($lines[$i] !~ /^\d/) {
        # If line of text does not start with a number, discard that line.
        splice(@lines, $i, 1);
        $i--;
    } else {
        # Grab the number from the beginning of each line of text. Store that
        # number in @dir_sizes_absolute. Numbers may be of arbitrary length, and may
        # contain dots (.) and commas (,). Examples of valid numbers:
        # 1
        # 1234567
        # 12.34567
        # 12,345.67
        # 1,234,567
        $lines[$i]  =~ /^(\S+)/;
        $number     = $1;
        $number     =~ s/,//g;
        $dir_sizes_absolute[$i] = $number;
    }

    # The fourth column of output from diruse.exe is, in most cases, a directory
    # name. Get rid of the first three columns in each line.
    $lines[$i] =~ s/^(\S+\s+){3}//;
}

# The last element of @lines describes the total size of the current directory.
# That line does not contain a directory name, and the total size of the current
# dir has already been noted, so there is no reason to keep that line.
splice(@lines, $#lines, 1);

# Find the character length of each directory name. This info will be used for
# formatting.
$max_line_len = 0;
foreach $line (@lines) {
    if(length($line) > $max_line_len) {
        $max_line_len = length($line);
    }
}

# Find amount of space each child directory consumes from the parent directory.
for($i = 0; $i < scalar(@lines); $i++) {
    $dir_sizes_percent[$i] = ($dir_sizes_absolute[$i] / $dir_sizes_absolute[-1]) * 100;
}

# Print out final results.
for($i = 0; $i < scalar(@lines); $i++) {
    # directory name
    print $lines[$i]
    # whitespace for formatting
    . ' ' x ($max_line_len - length($lines[$i]))
    # spacer
    . ' '
    # bar graph
    . '#' x (int($dir_sizes_percent[$i]) / 2)
    # spacer
    . ' '
    # percentage number
    . '(' . int($dir_sizes_percent[$i])  . '%)'
    # ...take a guess
    . "\n";
}
print "\nTOTAL: $dir_sizes_absolute[-1] $number_format\n";
