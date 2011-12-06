#!/usr/bin/env perl

use warnings;
use strict;

# use lib 'cookbook';

#==========================================================================
# Modules
#==========================================================================
use Cwd;
use Getopt::Long;
use File::Find;
use File::Basename;
use Module::Load;
use Data::Dumper;

no warnings 'File::Find'; # dont issue warnings for 'weird' files

use Recipe;

#==========================================================================
# main variables
#==========================================================================

my $default_cookbook = Cwd::abs_path(dirname(__FILE__) . "/" . "cookbook") ;
my $default_sandbox  = $ENV{HOME}."/"."tmp";
my $default_prefix   = "/usr/local";

my %options = ( prefix   => $default_prefix, 
								sandbox  => $default_sandbox, 
								cookbook => $default_cookbook, );
my %recipes = ();

#==========================================================================
# main functions
#==========================================================================

sub parse_commandline() # Parse command line
{
    GetOptions ( \%options,
			'prefix=s',
			'sandbox=s',
			'cookbook=s',
			'prefix=s',
			'help', 
			'verbose', 
			'debug',
			'list',
			'download',
			'cook',
			'packages=s@',
		); 
				
    # show help if required
    if( exists $options{help} )
    {
      print <<ZZZ;
cookup.pl : easy build and install for UNIX platforms

usage: cookup.pl <action> [options]

actions:
				--download          download the package sources
				--cook              cookup the packages following the recipe

options:
        --help              shows this help
        --verbose           print every comand before executing
        --debug level       sets the debug level
        --list              list all the recipes in the cookbook
        --prefix            install dir prefix (same as --install-dir) [$default_prefix]
        --cookbook          use directory as cookbook [$default_cookbook]
        --sandbox           use directory as sandbox for building [$default_sandbox]
        --packages=list     comma separated list of packages to apply actions on

ZZZ
    exit(0);
    }

		if( exists $options{packages} ) # process comma separated list
		{			
			my @packages = split(',',join(",",@{$options{packages}}));
			# print "@packages\n";
			$options{packages} = \@packages;
		}
		
		# resolve relative paths to absolute paths
		$options{prefix}   = Cwd::abs_path( $options{prefix}  );
		$options{sandbox}  = Cwd::abs_path( $options{sandbox} );
		$options{cookbook} = Cwd::abs_path( $options{cookbook});
}

sub found_recipe 
{		
		my ($name,$path,$suffix) = fileparse($_, qr/\.[^.]*/);
		#	print "path [$path] name [$name] suffix [$suffix]\n";
		if( $suffix eq ".pm") 
		{
	  		load $name;
				my $recipe  = $name->new();
				my $version = $recipe->version();
				$recipes{$name} = $recipe;
				if( $options{debug} ) { print "> found recipe for " . $recipe->name . "-" . $version . "\n" }
		}
}

sub find_recipes
{
	my @cookbook;
	my $cookbook_path = Cwd::abs_path($options{cookbook});
	push (@cookbook, $cookbook_path);
	if( $options{verbose} ) { print "searching for recipes in $cookbook_path\n" }
	find( \&found_recipe, @cookbook );	
}

sub list_available_recipes
{
	foreach my $package ( keys %recipes ) 
	{
			my $recipe = $recipes{$package};
			my $package_name = $recipe->package_name;
			print "$package_name ";	
			if( exists $options{verbose} ) { print $recipe->url; }
			print "\n";	
	} 
}	

sub process_packages
{
	foreach my $package ( @{$options{packages}} ) 
	{
		# check that recipe is in recipes list
		if( exists($recipes{$package}) )
		{
			my $recipe = $recipes{$package};
			my $package_name = $recipe->package_name;

			print "package [$package_name]\n";	

			  if( exists $options{verbose} ) { 
					$recipe->verbose( $options{verbose} ); 
				}

			  if( exists $options{debug} ) { 
					$recipe->debug( $options{debug} ); 
				}

			  $recipe->prefix ( $options{prefix } );
			  $recipe->sandbox( $options{sandbox} );

				if( exists $options{download} ) { 
		  		$recipe->download_src();
				}

				if( exists $options{cook} ) { 
		  		$recipe->cook();
				}
		} 
		else 
		{ 
			my $cookbook = $options{cookbook};
			die "no recipe for '$package' in our cookbook [$cookbook]" ;
		}		
	}
}	

#==========================================================================
# Main execution
#==========================================================================

parse_commandline();

push @INC, $options{cookbook};

find_recipes();

if( exists $options{list} )
{
	list_available_recipes();
}

if( exists $options{packages} )
{
	process_packages();
}
