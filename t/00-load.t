#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WebService::DarkSky' ) || print "Bail out!\n";
}

diag( "Testing WebService::DarkSky $WebService::DarkSky::VERSION, Perl $], $^X" );
