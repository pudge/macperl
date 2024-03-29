#!./perl -w

BEGIN {
    if ($ENV{PERL_CORE}) {
	chdir 't' if -d 't';
	@INC = '../lib';
    }
    undef *{Socket::inet_aton};
    undef *{Socket::inet_ntoa};
    if (ord('A') == 193 && !eval "require Convert::EBCDIC") {
        print "1..0 # EBCDIC but no Convert::EBCDIC\n"; exit 0;
    }
    $INC{'Socket.pm'} = 1;
}

package Socket;

sub import {
	my $pkg = caller();
	no strict 'refs';
	*{ $pkg . '::inet_aton' } = \&inet_aton;
	*{ $pkg . '::inet_ntoa' } = \&inet_ntoa;
}

my $fail = 0;
my %names;

sub set_fail {
	$fail = shift;
}

sub inet_aton {
	return if $fail;
	my $num = unpack('N', pack('C*', split(/\./, $_[0])));
	$names{$num} = $_[0];
	return $num;
}

sub inet_ntoa {
	return if $fail;
	return $names{$_[0]};
}

package main;


(my $libnet_t = __FILE__) =~ s/config.t/libnet_t.pl/;
require $libnet_t;

print "1..10\n";

use Net::Config;
ok( exists $INC{'Net/Config.pm'}, 'Net::Config should have been used' );
ok( keys %NetConfig, '%NetConfig should be imported' );

Socket::set_fail(1);
undef $NetConfig{'ftp_firewall'};
is( Net::Config->requires_firewall(), 0, 
	'requires_firewall() should return 0 without ftp_firewall defined' );

$NetConfig{'ftp_firewall'} = 1;
is( Net::Config->requires_firewall('a.host.not.there'), -1,
	'... should return -1 without a valid hostname' );

Socket::set_fail(0);
delete $NetConfig{'local_netmask'};
is( Net::Config->requires_firewall('127.0.0.1'), 0,
	'... should return 0 without local_netmask defined' );

$NetConfig{'local_netmask'} = '127.0.0.1/24';
is( Net::Config->requires_firewall('127.0.0.1'), 0,
	'... should return false if host is within netmask' );
is( Net::Config->requires_firewall('192.168.10.0'), 1,
	'... should return true if host is outside netmask' );

# now try more netmasks
$NetConfig{'local_netmask'} = [ '127.0.0.1/24', '10.0.0.0/8' ];
is( Net::Config->requires_firewall('10.10.255.254'), 0,
	'... should find success with mutiple local netmasks' );
is( Net::Config->requires_firewall('192.168.10.0'), 1,
	'... should handle failure with multiple local netmasks' );

is( \&Net::Config::is_external, \&Net::Config::requires_firewall,
	'is_external() should be an alias for requires_firewall()' );
