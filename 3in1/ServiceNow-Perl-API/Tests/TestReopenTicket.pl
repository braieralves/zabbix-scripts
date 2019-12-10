#!/usr/bin/perl -w

use ServiceNow;
use ServiceNow::Configuration;
use Test::Simple tests => 2;
my $CONFIG = ServiceNow::Configuration->new();
my $SN = ServiceNow->new($CONFIG);

my $number = $SN->createTicket({"short_description" => "this is the short description"});
print "number = " . $number . "\n";

my $ret1 = $SN->closeTicket($number, "600");
unless($ret1) {
	print "ticket " . $number . " not closed\n";
} else {
	print "ticket " . $number . " closed\n";
}

my $ret2;
$ret2 = $SN->reopenTicket($number);
ok(defined($ret2), 'Ticked Successfully reopened');

$ret2 = undef;

$ret2 = $SN->reopenTicket($number.'xxx');

ok(!defined($ret2), 'Successfully failed to reopen bogus ticket');



1;