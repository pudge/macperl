use ExtUtils::MakeMaker;

my %args = (
	'NAME'			=> 'MacPerl',
	'VERSION_FROM'		=> 'MacPerl.pm',
	'XSPROTOARG'		=> '-noprototypes', 		# XXX remove later?
);

# disable tests if set up outside current dir
use Cwd;
if ($ENV{PWD} && $ENV{PWD} ne cwd()) {
	*MY::test = sub { "test ::\n\t\@\$(NOOP)" };
}

if ($^O eq 'darwin') {
	$args{'LINKTYPE'}	= 'dynamic';
	$args{'OBJECT'}		= 'MacPerl.o OSA.o';
	$args{'INC'}		= '-I/Developer/Headers/FlatCarbon/';
	$args{'LDDLFLAGS'}	= '-bundle -flat_namespace -undefined suppress -framework Carbon';
}
if ($^O eq 'MacOS') {
	$args{'LINKTYPE'}	= 'static';
	$args{'SKIP'}		= [qw(dynamic dynamic_lib dynamic_bs)];
	$args{'OBJECT'}		= 'MacPerl.c XL.c OSA.c';
	$args{'INC'}	 	= "-i :::::XL:";
}

WriteMakefile(%args);
