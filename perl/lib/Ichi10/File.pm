#!/usr/bin/perl
use strict;
use warnings;

package Ichi10::File;
use File::Spec;

########################################
# SUBROUTINE
#
# This subroutine acts as a constructor for 'File' objects.
# $_[0]
#   Scalar string. An absolute path pointing to a thingy, such as a file,
#   directory, or block device.
########################################
sub new {
    my $class       = shift;
    my $abs_path    = shift; # $_[0]

    my ($volume, $path, $filename) = File::Spec->splitpath($abs_path);
    my $new_object = +{
        path        => $path,
        name        => $filename,
        type        => undef,
        read        => (-r $abs_path)? 1: 0,
        write       => (-w $abs_path)? 1: 0,
        execute     => (-x $abs_path)? 1: 0,
    };
    if(-f $abs_path) {
        $new_object->{type} = 'file';
    } elsif(-d $abs_path) {
        $new_object->{type} = 'directory';
    } else {
        $new_object->{type} = 'other';
    }

    bless $new_object, $class;
    return $new_object;
}

########################################
# SUBROUTINE
#
# Does not accept any arguments.
# Returns a human-readable string containing all attributes of this object.
########################################
sub toString {
    my $self = shift;
    return sprintf("%-10s %s%s%s %s",
        $self->{type},
        $self->{read}    ? 'r' : '-',
        $self->{write}   ? 'w' : '-',
        $self->{execute} ? 'x' : '-',
        File::Spec->catfile($self->{path}, $self->{name}),
    );
}

########################################
# SUBROUTINE
#
# Does not accept any arguments.
# Deletes file from system.
########################################
sub delete {
    my $self = shift;
    system("rm -f ".File::Spec->catfile($self->{path}, $self->{name}));
    return 1;
}

########################################
# SUBROUTINE
#
# Does not accept any arguments.
# Returns "ls -l FILE"
########################################
sub list {
    my $self = shift;
    system("ls -l ".File::Spec->catfile($self->{path}, $self->{name}));
    return 1;
}

1; # return true
