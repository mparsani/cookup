# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package curl;

use strict;
use warnings;

use Recipe;

my %fields = (
    name     => "curl",
    version  => "7.23.1",
		url      => "http://curl.haxx.se/download/curl-7.23.1.tar.gz",
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
			return "./configure --without-ssl --without-libidn --without-gnutls --disable-ipv6 --prefix=" . $self->prefix;
		}

        sub md5  { return "8e23151f569fb54afef093ac0695077d"; }    


1;
