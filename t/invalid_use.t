# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl DBD-Pg-hstore.t'

#########################

use strict;
no warnings 'uninitialized';

use Test::More tests=>13;
BEGIN { use_ok('Pg::hstore') };

#########################

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


is_deeply( Pg::hstore::decode(undef), {});
is_deeply( Pg::hstore::decode(''), {});
is_deeply( Pg::hstore::decode('wtf'), {});
is_deeply( Pg::hstore::decode('fw"fw'), {});
is_deeply( Pg::hstore::decode("as'sdf"), {});
is_deeply( Pg::hstore::decode([]), {});
is_deeply( Pg::hstore::decode({}), {});
