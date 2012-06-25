# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl DBD-Pg-hstore.t'

#########################

use strict;
no warnings 'uninitialized';

use Test::More tests=>28;
BEGIN { use_ok('Pg::hstore') };

#########################
*R = sub {};

is( Pg::hstore::encode(''), undef);
is( Pg::hstore::encode('wtf'), undef);
is( Pg::hstore::encode(undef), undef);
my $wtf = {};
is( Pg::hstore::encode($wtf->{nonexist1}), undef);
sub test {
	my ($a) = @_;
	is( Pg::hstore::encode($a->{nonexist2}), undef);
}
test($wtf);
is( Pg::hstore::encode(0), undef);
is( Pg::hstore::encode(1), undef);
is( Pg::hstore::encode($1), undef, 'readonly scalar test');
is( Pg::hstore::encode([]), undef);
is( Pg::hstore::encode(*R), undef);



is_deeply( Pg::hstore::decode(undef), {});
is_deeply( Pg::hstore::decode(*R), {});
is_deeply( Pg::hstore::decode($1), {}, 'readonly scalar test');
is_deeply( Pg::hstore::decode(''), {});
is_deeply( Pg::hstore::decode('wtf'), {});
is_deeply( Pg::hstore::decode('fw"fw'), {});
is_deeply( Pg::hstore::decode('"fw"=>"fw'), {fw=>'fw'});
is_deeply( Pg::hstore::decode('"fw"=>"\"'), {fw=>'"'});
is_deeply( Pg::hstore::decode('"fw"=>\"'), {});
is_deeply( Pg::hstore::decode('"fw"=>'), {});
is_deeply( Pg::hstore::decode('"fw"='), {});
is_deeply( Pg::hstore::decode('"fw"'), {});
is_deeply( Pg::hstore::decode('"fw\"'), {});
is_deeply( Pg::hstore::decode("as'sdf"), {});
is_deeply( Pg::hstore::decode([]), {});
is_deeply( Pg::hstore::decode({}), {});

my %h;
undef(%h);
is( Pg::hstore::encode(\%h), '');
