#!./perl

BEGIN {
    if ($ENV{PERL_CORE}) {
	chdir 't' if -d 't';
	@INC = '../lib';
    }
    if (ord('A') == 193 && !eval "require Convert::EBCDIC") {
        print "1..0 # EBCDIC but no Convert::EBCDIC\n"; exit 0;
    }
}

use strict;

use Cwd;
print "1..20\n";

# for testing _readrc
$ENV{HOME} = Cwd::cwd();

# avoid "used only once" warning
local (*CORE::GLOBAL::getpwuid, *CORE::GLOBAL::stat);

*CORE::GLOBAL::getpwuid = sub ($) {
	((undef) x 7, Cwd::cwd());
};

# for testing _readrc
my @stat;
*CORE::GLOBAL::stat = sub (*) {
	return @stat;
};

# for testing _readrc
$INC{'FileHandle.pm'} = 1;

(my $libnet_t = __FILE__) =~ s/\w+.t$/libnet_t.pl/;
require $libnet_t;

# now that the tricks are out of the way...
eval { require Net::Netrc; };
ok( !$@, 'should be able to require() Net::Netrc safely' );
ok( exists $INC{'Net/Netrc.pm'}, 'should be able to use Net::Netrc' );

SKIP: {
	skip('incompatible stat() handling for OS', 4), next SKIP 
		if ($^O =~ /os2|win32|macos|cygwin/i or $] < 5.005);
	
	my $warn;
	local $SIG{__WARN__} = sub {
		$warn = shift;
	};

	# add write access for group/other
	$stat[2] = 077;
	ok( !defined(Net::Netrc::_readrc()),
		'_readrc() should not read world-writable file' );
	ok( $warn =~ /^Bad permissions:/, '... and should warn about it' );

	# the owner field should still not match
	$stat[2] = 0;

        if ($<) { 
          ok( !defined(Net::Netrc::_readrc()), 
              '_readrc() should not read file owned by someone else' ); 
          ok( $warn =~ /^Not owner:/, '... and should warn about it' ); 
        } else { 
          skip("testing as root",2);
        } 
}

# this field must now match, to avoid the last-tested warning
$stat[4] = $<;

# this curious mix of spaces and quotes tests a regex at line 79 (version 2.11)
FileHandle::set_lines(split(/\n/, <<LINES));
macdef bar
login	baz
 machine "foo"
login	nigol "password" drowssap
machine foo "login"	l2
	password p2
account tnuocca
default	login "baz" password p2
default "login" baz password p3
macdef
LINES

# having set several lines and the uid, this should succeed
is( Net::Netrc::_readrc(), 1, '_readrc() should succeed now' );

# on 'foo', the login is 'nigol'
is( Net::Netrc->lookup('foo')->{login}, 'nigol', 
	'lookup() should find value by host name' );

# on 'foo' with login 'l2', the password is 'p2'
is( Net::Netrc->lookup('foo', 'l2')->{password}, 'p2',
	'lookup() should find value by hostname and login name' );

# the default password is 'p3', as later declarations have priority
is( Net::Netrc->lookup()->{password}, 'p3', 
	'lookup() should find default value' );

# lookup() ignores the login parameter when using default data
is( Net::Netrc->lookup('default', 'baz')->{password}, 'p3',
	'lookup() should ignore passed login when searching default' );

# lookup() goes to default data if hostname cannot be found in config data 
is( Net::Netrc->lookup('abadname')->{login}, 'baz',
	'lookup() should use default for unknown machine name' );

# now test these accessors
my $instance = bless({}, 'Net::Netrc');
for my $accessor (qw( login account password )) {
	is( $instance->$accessor(), undef, 
		"$accessor() should return undef if $accessor is not set" );
	$instance->{$accessor} = $accessor;
	is( $instance->$accessor(), $accessor,
		"$accessor() should return value when $accessor is set" );
}

# and the three-for-one accessor
is( scalar( () = $instance->lpa()), 3, 
	'lpa() should return login, password, account');
is( join(' ', $instance->lpa), 'login password account', 
	'lpa() should return appropriate values for l, p, and a' );

package FileHandle;

sub new {
	tie *FH, 'FileHandle', @_;
	bless \*FH, $_[0];
}

sub TIEHANDLE {
	my ($class, $file, $mode) = @_[0,2,3];
	bless({ file => $file, mode => $mode }, $class);
}

my @lines;
sub set_lines {
	@lines = @_;
}

sub READLINE {
	shift @lines;
}

sub close { 1 }

