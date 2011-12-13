# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl DBD-Pg-hstore.t'

#########################

use strict;
use warnings;
use Data::Dumper;

use Test::More tests=>25;
BEGIN { use_ok('Pg::hstore') };

#########################

while( my $row = <DATA> ) {
	my $t1 = Pg::hstore::decode($row);

	my $srcrow=$row;
	$row  =~ s/\=\>\s*NULL/\=\>undef/gs;
	$row  =~ s/([\@\$\%])/\\$1/gs;
	my $t2 = eval "{$row}";
	is_deeply($t1, $t2, "Test string $srcrow");
}

my @addtests=(
	"\"win1251\" => \"\xc4\xee\xea\xee\xeb\xe5\x3f\"",
	"\"binary\" => \"\x07\x03\xdb\xdb\x7a\xa7\xda\xad\x49\x94\xa0\x0a\"",
	"\"tab\" =>\"\t\"",
	"\"\t\"=>\"tab\""
);
foreach my $row (@addtests) {
	my $t1 = Pg::hstore::decode($row);

	my $srcrow=$row;
	$row  =~ s/\=\>\s*NULL/\=\>undef/gs;
	$row  =~ s/([\@\$\%])/\\$1/gs;
	my $t2 = eval "{$row}";
	is_deeply($t1, $t2, "Test string $srcrow");
}


__DATA__
"test"=>"1"
"slash"=>"\\"
"doubleslash"=>"\\\\"
"quote"=>"\"",
"a" => "1" , "b"=>"2", "c" =>NULL,
"spec" => "~!@#$%^&*()_+|-=\\/';\",.[]{}:<>?`"
"russian" => "Доколе?",
"empty"=> "", "NULL"=>NULL

"1"=>"test"
"\\"	=>"slash"
"\\\\"=>"doubleslash"
"\""=>	"quote"
"~!@#$%^&*()_+|-=\\/';\",.[]{}:<>?`"=>"spec"
"Доколе?"=>"russian"

	"all"=> "2gether", "test"=>"1" , "empty"=> "","slash"=>"\\","doubleslash"=>"\\\\","quote"=>"\""   ,"a" => "1" , "b"=>"2", "c" =>NULL,"spec" => "~!@#$%^&*()_+|-=\\/';\",.[]{}:<>?`","russian" => "Доколе?","1"=>"test", "\\"=>"slash" , "\\\\"=>"doubleslash"  ,"\""=>"quote",    "~!@#$%^&*()_+|-=\\/';\",.[]{}:<>?`"=>"spec","Доколе?"=>"russian",

"site_url"=>"http://test.domain.ru", "max_downloads"=>"-1", "support_email"=>"support@test.ru"
"price"=>"35.88", "shortnum"=>"770111", "period_id"=>"1", "price_desc"=>"11111 р/нед", "prolong_type"=>"402", "sale_gateway_id"=>"1013", "infosms_src_addr"=>"770111", "shortnum_prolong"=>"770111", "price_currency_id"=>"1", "shortnum_start_is_prepaid"=>"0"