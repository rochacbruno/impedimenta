#!/usr/bin/perl
use strict;
use warnings;

################################################################################
# DESCRIPTION
#
# Script Name:              lab5_p2.pl
# Original Creation Date:   Jan 16, 2012
# Original Author:          Jeremy Audet
#
# Reads in a set of user names, ages, and GPAs. Formats this data to be pretty,
# and prints it out to a file of the user's choice.
################################################################################

################################################################################
# GLOBAL DECLARATIONS
################################################################################
use constant CONTINUE       => 1;
use constant STOP           => 0;
use constant AGE_MAX        => 150;
use constant AGE_MIN        => 1;
use constant GPA_MAX        => 4.0;
use constant GPA_MIN        => 0.0;

my @names                   = ();
my @ages                    = ();
my @GPAs                    = ();
my $filename                = '';

################################################################################
# MAIN
################################################################################
while(CONTINUE == &Read_Continue()) {
    push(@names,    &Read_Name());
    push(@ages,     &Read_Age());
    push(@GPAs,     &Read_GPA());
}
$filename = &Read_File_Name();
&Write_To_File($filename, \@names, \@ages, \@GPAs);

# print "\n"
#     . "----------------------------------------\n"
#     . "DEBUGGING INFO\n"
#     . "\@names: <@names>\n"
#     . "\@ages: <@ages>\n"
#     . "\@GPAs: <@GPAs>\n"
#     . "\$filename: <$filename>\n"
#     . "----------------------------------------\n";

################################################################################
# SUBROUTINES
################################################################################

# Returns CONTINUE or STOP.
sub Read_Continue {
    my $choice = '';

    print 'Enter student data? ';
    chomp($choice = <STDIN>);
    $choice = &Trim($choice);
    while($choice !~ m/^[YyNn]$/) {
        print "Answer must be 'y', 'Y', 'n', or 'N'\n";
        print 'Enter student data? ';
        chomp($choice = <STDIN>);
        $choice = &Trim($choice);
    }

    if($choice =~ m/^[Yy]$/) {
        return CONTINUE;
    } else {
        return STOP;
    }
}

# Returns a name with leading and trailing whitespace stripped.
sub Read_Name {
    my $name = '';

    print 'Name? ';
    chomp($name = <STDIN>);
    $name = &Trim($name);

    return $name;
}

# Returns an age between AGE_MAX and AGE_MIN, inclusive.
sub Read_Age {
    my $age = 0;

    print 'Age?  ';
    chomp($age = <STDIN>);
    $age = &Trim($age);
    while(($age !~ m/^(\d{1,2})$/) or ($age < AGE_MIN) or ($age > AGE_MAX)) {
        if($age !~ m/^(\d{1,2})$/) {
            print "Age must be a one or two-digit number. For example, 8 or 72\n";
        } else {
            print "Age must be a number between " . AGE_MIN . " and " . AGE_MAX . " , inclusive.\n";
        }
        print 'Age?  ';
        chomp($age = <STDIN>);
        $age = &Trim($age);
    }

    return $age;
}

# Returns a GPA between GPA_MIN and GPA_MAX, inclusive.
sub Read_GPA {
    my $gpa = 0;

    print 'GPA?  ';
    chomp($gpa = <STDIN>);
    $gpa = &Trim($gpa);
    while(($gpa !~ m/^\d\.\d$/) or ($gpa < GPA_MIN) or ($gpa > GPA_MAX)) {
        if($gpa !~ m/^\d\.\d$/) {
            print "GPA must be a decimal number in the format \'X.Y\'. For example, 0.3 is valid, but .3 is not.\n";
        } else {
            print "GPA must be a number between " . GPA_MIN . " and " . GPA_MAX . ", inclusive.\n";
        }
        print 'GPA?  ';
        chomp($gpa = <STDIN>);
        $gpa = &Trim($gpa);
    }

    return $gpa;
}

# Returns a filename.
sub Read_File_Name {
    my $filename = '';

    print 'Filename? ';
    chomp($filename = <STDIN>);

    return $filename;
}

# Writes data out to a file. Data is formatted into columns before being printed.
# Arguments:
# $_[0] filename (treated as a string)
# $_[1] ref to array of names (treated as strings)
# $_[2] ref to array of ages (treated as ints)
# $_[3] ref to array of gpas (treated as floats)
sub Write_To_File {
    if(scalar(@_) != 4) {
        print STDERR "Incorrect number of arguments to sub " . (caller(0))[3] . "\n";
        print STDERR "Terminating program.\n";
    }

    my $filename    = $_[0];
    my $names_ref   = $_[1];
    my $ages_ref    = $_[2];
    my $gpas_ref    = $_[3];

    open(FILE, '>', $filename) || die("Cannot open or create file \'$filename\': $!\n");
    for(my $i = 0; $i < scalar(@$names_ref); $i++) {
        printf FILE ("%-25.25s %3.1d %2.1f\n", $$names_ref[$i], $$ages_ref[$i], $$gpas_ref[$i]);
    }
    close(FILE) || die("Cannot close file \'$filename\': $!\n");

    return;
}

sub Trim {
    my $arg = $_[0];

    $arg =~ s/^\s+//;
    $arg =~ s/\s+$//;

    return $arg;
}

################################################################################
# TEMPLATES
################################################################################
