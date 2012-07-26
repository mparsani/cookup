# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package libunwind;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "libunwind",
    version  => "1.0.1",
	url      => "http://download.savannah.gnu.org/releases/libunwind/libunwind-1.0.1.tar.gz",
	md5      => "993e47cca7315e22239c3e0d987e94e0",
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

1;
