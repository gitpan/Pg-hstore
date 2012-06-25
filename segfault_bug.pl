#!/usr/local/bin/perl

use ExtUtils::Command::MM;

use strict;
use lib qw(./blib/lib ./blib/lib/auto ./blib/arch/auto ./blib/arch/auto/Pg/hstore);
use Pg::hstore;
use Data::Dumper;

print Pg::hstore::encode(''); #bus error
print Pg::hstore::encode('wtf'); #bus error
print Pg::hstore::encode(undef); #bad hash
print Pg::hstore::encode({a=>123}); #ok
my $wtf = {};
print Pg::hstore::encode($wtf->{nonexist1}); #bad hash
sub test {
	my ($a) = @_;
	print Pg::hstore::encode($a->{nonexist2}); #bad hash
}
test($wtf);

Pg::hstore::decode(undef);
Pg::hstore::decode('');
Pg::hstore::decode('wtf');
Pg::hstore::decode('fw"fw');
print Dumper(Pg::hstore::decode('"fw"=>"234\'"'));
Pg::hstore::decode("as'sdf");
Pg::hstore::decode("as'sdf");
Pg::hstore::decode([]);
Pg::hstore::decode({});
