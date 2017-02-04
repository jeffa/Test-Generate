#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 3;

BEGIN {
    use_ok( 'Test::Generate' ) || print "Bail out!\n";
}

use_ok( 'Test::Generate::Lang' );
use_ok( 'Test::Generate::Lang::Perl' );
