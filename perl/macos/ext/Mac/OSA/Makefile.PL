use ExtUtils::MakeMaker;
use File::Spec::Functions;

my $mod = 'OSA';
my %args = (
	'NAME'			=> "Mac::$mod",
	'VERSION_FROM'		=> "$mod.pm",
	'LINKTYPE'		=> 'static dynamic',
	'XSPROTOARG'		=> '-noprototypes', 		# XXX remove later?

	'TYPEMAPS'		=> [
		catfile(updir(), 'Components', 'typemap'),
	],
);

# disable tests if set up outside current dir
use Cwd;
if ($ENV{PWD} && $ENV{PWD} ne cwd()) {
	*MY::test = sub { "test ::\n\t\@\$(NOOP)" };
}

if ($^O eq 'darwin') {
	$args{'INC'}		= '-I/Developer/Headers/FlatCarbon/';
	$args{'LDDLFLAGS'}	= '-bundle -flat_namespace -undefined suppress -framework Carbon';
}
if ($^O eq 'MacOS') {
	$args{'MACLIBS_SHARED'}	= '"{{SharedLibraries}}"AppleScriptLib';
}

WriteMakefile(%args);
