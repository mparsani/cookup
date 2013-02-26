# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package boost;

use strict;
use warnings;

use Recipe;

my %fields = ();

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
    
    sub name       { return "boost"; }
    sub version    { return "1.52.0"; }
    sub url        { return "http://download.sourceforge.net/boost/boost_1_52_0.tar.gz"; }

    sub package_dir { return "boost_1_52_0"; }

    sub md5  { return "f62451fa646ca392b0fbc08beb23ad12"; }
    sub sha1 { return "1120430030315b0a94b6d63fc04662960db2444c"; }

    # string for the configure command
    sub configure_command {
    my $self = shift;
    return "./bootstrap.sh --prefix=" . $self->prefix;
    }

    # string for the build command
    # in this case it also installs
    sub build_command {
        my $self = shift;
        return "./b2 --prefix=".$self->prefix." variant=release link=shared threading=multi install";
    }

    # no install, done together with the build
    sub install {}

1;
