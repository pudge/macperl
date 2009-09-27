use Config;
use vars qw($bits_are_64 $usrlocal $defarch);

$bits_are_64 = unpack("L!", pack("LL", 0x12345678, 0x9ABCDEF)) >= 2**32;
$usrlocal = scalar(grep m|^/usr/local/|, @INC);
$defarch = $Config{byteorder} eq 1234 ? 'i386' : 'ppc';

sub fixargs {
	my $ARGS = shift;
	for (qw(LDDLFLAGS LDFLAGS CCFLAGS)) {
		$ARGS->{$_} =~ s/\s?-arch x86_64\s?/ /g;
#		$ARGS->{$_} =~ s/\s?-arch ppc(?:\d+)?\s?/ /g;
		$ARGS->{$_} =~ s|-[LI]/usr/local/\S+| |g unless $usrlocal > 1;
		if ($ARGS->{$_} !~ /\barch/) {
			$ARGS->{$_} .= " -arch $defarch";
		}
	}
}

