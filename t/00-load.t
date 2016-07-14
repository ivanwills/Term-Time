#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::Warnings;

BEGIN {
    use_ok( 'Term::Time' );
}

diag( "Testing Term::Time $Term::Time::VERSION, Perl $], $^X" );
done_testing();
