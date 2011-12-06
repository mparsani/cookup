#!/usr/bin/env perl

use warnings;
use strict;

#==========================================================================
# Modules
#==========================================================================
use Cwd;
use Getopt::Long;
use File::Find;

no warnings 'File::Find';

#==========================================================================
# Global Variables
#==========================================================================

my $opt_help          = 0;
my $opt_verbose       = 0;

#==========================================================================
# Command Line
#==========================================================================

sub parse_commandline() # Parse command line
{
    $opt_help=1 unless GetOptions (
        'help'                  => \$opt_help,
        'verbose'               => \$opt_verbose,
    );

    # show help if required
    if ($opt_help != 0)
    {
      print <<ZZZ;
cookup.pl : easy build and install for UNIX platforms

usage: cookup.pl [options]

options:
        --help             Show this help.
        --verbose          Print every comand before executing.
ZZZ
    exit(0);
    }
}

#==========================================================================
# Main execution
#==========================================================================

parse_commandline();


use fl

# my $recipe = flex->new();
# $recipe->debug(1);
# $recipe->install_dir( cwd() );
# $recipe->install();