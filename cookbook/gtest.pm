# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package gtest;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "gtest",
    version  => "1.6.0",
	url      => "http://googletest.googlecode.com/files/gtest-1.6.0.zip",
);

our @ISA = ("Recipe");

    sub new
		{
        my $class = shift;
        my $self  = $class->SUPER::new();
        my($element);
        foreach $element (keys %fields) {
            $self->{_permitted}->{$element} = $fields{$element};
        }
        @{$self}{keys %fields} = values %fields;
        return $self;
    }

    sub configure_command {
        my $self = shift;
        return "cmake"; # gtest does not install
    }

    sub md5  { return "4577b49f2973c90bf9ba69aa8166b786"; }    

1;
