# © Copyright 2011-2012 Tiago Quintino
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

package grib_api_1_9_9;

use strict;
use warnings;

use grib_api;

my %fields = ();

our @ISA = ("grib_api");

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

    sub version    { return "1.9.9"; }
    sub url        { return "http://www.ecmwf.int/products/data/software/download/software_files/grib_api-1.9.9.tar.gz"; }
    
    sub md5  { return "fe6c684e4a41477f3a6e97ab8892f35d"; }
    sub sha1 { return ""; }

1;
