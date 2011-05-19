#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'DBIx::Class::InflateColumn::BigFloat' ) || print "Bail out!\n";
}

diag( "Testing DBIx::Class::InflateColumn::BigFloat $DBIx::Class::InflateColumn::BigFloat::VERSION, Perl $], $^X" );
