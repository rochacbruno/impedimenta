#! /usr/bin/perl

$word = "aegiou";

print "Before search/replace operation, word = $word\n";
$word =~ s/aeiou/-/;
print "After search/replace operation, word = $word\n\n";

$word = "aegiou";
print "Before transliteration, word = $word\n";
$word =~ tr/aeiou/-/;
print "After transliteration, word = $word\n";
