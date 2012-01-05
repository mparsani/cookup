package cmake;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "cmake",
    version  => "2.8.7",
		url      => "http://www.cmake.org/files/v2.8/cmake-2.8.7.tar.gz",
		md5      => "e1b237aeaed880f65dec9c20602452f6",
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

		# string for the configure command
		sub configure_command {
			my $self = shift;
			return "./bootstrap --prefix=" . $self->prefix;
		}

1;
