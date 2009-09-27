use Config;
use 5.006;
use ExtUtils::MakeMaker;
require 'fixargs.pl';

if ($bits_are_64) {
	$| = 1;
	print "*** 64-BIT WARNING ***  *** 64-BIT WARNING ***  *** 64-BIT WARNING ***
Mac-Carbon does not run under 64-bit perl, and it appears you're running
a 64-bit perl.  We can try to compile anyway, in case this is a fat binary:
we'll try to leave out the 64-bit compilation.  Give it a go? [Yn] ";
	if (<> =~ /n/i) {
		print "\nExiting.\n\n";
		exit;
	} else {
		print "\nIf you want to use these modules, it must be in 32-bit mode.
For more information, see:\n\n\thttp://use.perl.org/~pudge/journal/39596\n\n";
	}
}

my %ARGS= (
	'NAME'                  => 'Mac::Carbon',
	'VERSION_FROM'          => 'Carbon.pm',
	'PM'                    => { 'Carbon.pm' => '$(INST_LIBDIR)/Carbon.pm' },
	'PREREQ_PM'  => {
    		'Test::More'    => 0,
	},
	'clean'      => {
		'FILES'         => 'Mac-Carbon-*'
	},
	'test'       => {
		'TESTS'         => 't/*.t */t/*.t'
	},
	'NO_META'               => 1,
);

for (qw(LDDLFLAGS LDFLAGS CCFLAGS)) {
	$ARGS{$_} = $Config{lc $_};
}
fixargs(\%ARGS);

package MY;
if ($^O eq 'darwin') {
	sub test_via_harness {
	    my($self, $perl, $tests) = @_;
	    return $self->SUPER::test_via_harness("VERSIONER_PERL_PREFER_32_BIT=yes $perl", $tests);
	}

	sub test_via_script {
	    my($self, $perl, $script) = @_;
	    return $self->SUPER::test_via_script("VERSIONER_PERL_PREFER_32_BIT=yes $perl", $script);
	}
}

package main;
WriteMakefile(%ARGS);
