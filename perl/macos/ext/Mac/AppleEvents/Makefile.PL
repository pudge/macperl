use ExtUtils::MakeMaker;

my $mod = 'AppleEvents';
my %args = (
	'NAME'			=> "Mac::$mod",
	'VERSION_FROM'		=> "$mod.pm",
	'LINKTYPE'		=> 'static dynamic',
	'XSPROTOARG'		=> '-noprototypes', 		# XXX remove later?
);

# disable tests if set up outside current dir
use Cwd;
if ($ENV{PWD} && $ENV{PWD} ne cwd()) {
	*MY::test = sub { "test ::\n\t\@\$(NOOP)" };
}

if ($^O eq 'darwin') {
	$args{'INC'}		= '-I/Developer/Headers/FlatCarbon/';
	$args{'LDDLFLAGS'}	= '-lstdc++ -bundle -flat_namespace -undefined suppress -framework Carbon';
	$args{'OBJECT'}		= 'AppleEvents.o PerlAEUtils.o';

	# i'm sure there's a way to tell MakeMaker to use .cp,
	# but this is easier
	require File::Copy;
	File::Copy::copy('PerlAEUtils.cp', 'PerlAEUtils.cpp');
}
if ($^O eq 'MacOS') {
	$args{'INC'}		= '-i $(PERL_SRC):AEGizmos:include:';
	$args{'OBJECT'}		= 'AppleEvents.c.o PerlAEUtils.cp.o';
	$args{'MACLIBS_SHARED'}	= '"::::::AEGizmos:AEGizmos4Perl.shlb.PPC" ';
}

WriteMakefile(%args);
