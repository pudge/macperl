use ExtUtils::MakeMaker;

my $mod = 'Types';
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
	$args{'LDDLFLAGS'}	= '-bundle -flat_namespace -undefined suppress -framework Carbon';
}

WriteMakefile(%args);
