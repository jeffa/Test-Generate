#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Test::Generate' ) || print "Bail out!\n";
}

diag( "Testing Test::Generate $Test::Generate::VERSION, Perl $], $^X" );
