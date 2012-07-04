#! /usr/bin/perl -w

$input = "I am a test string.\n";

$numWords = countWords($input);
print "$numWords\n";

sub countWords {
	my $string = $_[0];
	my $wordCount = 0;

	while ($string =~ /\b\w*\b/g) {
		++$wordCount;
	}

	return $wordCount;
}
