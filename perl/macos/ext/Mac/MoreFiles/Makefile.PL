use ExtUtils::MakeMaker;

my $mod = 'MoreFiles';
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
	my $src = 'MoreFilesSrc';
	# we only compile these separately for Mac OS X right now, so
	# we keep them in a separate directory and copy them in when needed
	require File::Copy;
	opendir my $dh, $src or die $!;
	File::Copy::copy($_, '.') for map { "$src/$_" } grep { /\.c$/ } readdir($dh);
	# all our C_FILES are generated or copied into place
	$args{'clean'}          = { FILES => '$(C_FILES)' };

	$args{'INC'}		= "-I/Developer/Headers/FlatCarbon/ -I./$src";
	$args{'LDDLFLAGS'}	= '-bundle -flat_namespace -undefined suppress -framework Carbon';
	$args{'OBJECT'}		= '$(O_FILES)';
}
if ($^O eq 'MacOS') {
	$args{'INC'}		= '-i "$(PERL_SRC):MoreFiles:CHeaders:"';
	$args{'OBJECT'}		= 'MF.c';
}

WriteMakefile(%args);
