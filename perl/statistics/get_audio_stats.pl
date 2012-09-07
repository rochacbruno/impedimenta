#!/usr/bin/perl
use strict;
use warnings;

{
    my @dependencies = qw(du mutagen-inspect find);
    foreach my $dependency (@dependencies) {
        unless (`which $dependency 2>/dev/null`) {
            die("$dependency not found. Either install or add location of program to PATH.\n");
        }
    }
}

########################################
#   Summary
# Recursively scans the given directory for audio files. Extracts the length,
# size, and encoding of each audio file, then prints said info out.
########################################

unless(1 == scalar(@ARGV)) {
    print "Usage: $0 <path_to_root_of_music_lib>\n";
    exit;
}

my $music_lib = shift(@ARGV);

# Then get and print info about one file at a time.
open(PIPE_IN_FIND, "find -H \"$music_lib\" -type f |") or die("Cannot open pipe: $!\n");
while(my $file = <PIPE_IN_FIND>) {
    chomp $file;
    my $mutagen_info    = '';
    my $file_length     = 0;
    my $file_size       = 0;
    my $file_type       = '';

    # populate $file_length and $file_type
    open(PIPE_IN_MUTAGEN, "mutagen-inspect \"$file\" | head -n 2 | tail -n 1 |") or warn("Cannot open pipe: $!\n");
    $mutagen_info = <PIPE_IN_MUTAGEN>;
    next if ($mutagen_info !~ /seconds/);
    next if ($mutagen_info !~ /audio/);
    # .mov files produce output like this: MPEG-4 audio, 130.50 seconds, 0 bps (audio/mp4)
    next if ($mutagen_info =~ / 0 bps/);
    $mutagen_info   =~ /(\d+\.\d+)\s+seconds/;
    $file_length    = $1;
    $mutagen_info   =~ /audio\/(\S+)\)/;
    $file_type      = $1;
    close(PIPE_IN_MUTAGEN) or die("Cannot close pipe: $!\n");

    # populate $file_size
    open(PIPE_IN_DU, "du -BK \"$file\" |") or warn("Cannot open pipe: $!\n"); # scale to MK
    $file_size = <PIPE_IN_DU>;
    $file_size =~ m/^(\d+)/;
    $file_size = $1;
    close(PIPE_IN_DU) or die("Cannot close pipe: $!\n");

    print "$file_length $file_size $file_type\n";
}
close(PIPE_IN_FIND) or die("Cannot close pipe: $!\n");
