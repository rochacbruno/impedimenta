#! /usr/bin/perl
#
# PSEUDOCODE
# display menu;
# prompt user for input;
# while user has not chosen to exit,
#	either issue or redeem a ticket;
#	display a menu;
#	prompt user for input;
#
# SUB issue_ticket
# read first entry in ticketdb;
# while entry is a 1,			# 1 indicates that ticket has been issued,
#	read next entry in ticketdb;	# 0 indicates that ticket has not been issued
# change value of entry read to 1;
# issue car wash ticket with appropriate number;
# END;
#
# SUB redeem_ticket
# ask user to enter their ticket number;
# prompt user for ticket number;
# if ticketdb shows that ticket number has been issued (is 1),
#	change database number to 0;
#	thank user for business;
# elsif ticketdb shows that ticket number has not been issued (is 0),
#	tell user that that their ticket number is invalid;
# END;

my $answer = 0;
@ticketdb[9999] = (0..0);

while($answer != 3) {			# continues to loop, as long as user has not chosen to exit
	menu();
	chomp($answer = <STDIN>);
	while($answer != 1 && $answer != 2 && $answer != 3) {	# make sure input is valid
		print "Answer must be 1, 2, or 3\n";
		menu();
		chomp($answer = <STDIN>);
	}
	if($answer == 1) {
		issue_ticket();
	} elsif($answer == 2) {
		redeem_ticket();
	} else {
		;			# if input is 3, this statement is necessary
	}
}

sub menu {
	print "\nPress 1 to Issue a Carwash Ticket\n";
	print "Press 2 to Redeem a Carwash Ticket\n";
	print "Press 3 to Exit\n>";
}

sub issue_ticket {
	my $index = 0;
	my $ticketdb_val = 0;

	$ticketdb_val = @ticketdb[$index];
	while ($ticketdb_val == 1 && $index < 9999) {
		$index++;
		$ticketdb_val = @ticketdb[$index];
	}
	if ($ticketdb_val == 1) {
		print "I'm sorry, all tickets have been issued.\n";
	} else {
		@ticketdb[$index] = 1;
		printf ("Your ticket number is: %0.4d\n", $index + 1);
		print "Thank you, please come again!\n";
	}		
}

sub redeem_ticket {
	my $ticket_number = 0;

	print "Please enter your ticket number.\n>";
	chomp($ticket_number = <STDIN>);
	if ($ticket_number < 1 || $ticket_number > 10000 || @ticketdb[$ticket_number - 1] == 0) {
		print "I'm sorry, that's not a valid ticket number.\n";
	} else {
		print "Welcome to the Best Carwash Ever. Enjoy your clean car!\n";
		@ticketdb[$ticket_number - 1] = 0;
	}
}
