#! /usr/bin/perl
#
# menunav.pl
# see if I can create a working menu
#
# PSEUDOCODE
# show user screen one
# give options: continue, about, exit
# if user hits continue,
#	show user screen two
# give options: continue, back, exit
# if user hits continue, 
#	show user screen three
# give options: continue, back, exit

$reply = "";

sub clear_screen {
	print "\n" x 60;
}

sub menu1 {
	print "Continue (Enter)		About (a)		Exit (e)\n>";
}

sub menu2 {
	print "Continue (Enter)		Back (b)		Exit (e)\n>";
}
