use ExtUtils::MakeMaker;

WriteMakefile(
	'NAME'			=> 'Mac::Carbon',
	'VERSION_FROM'		=> 'Carbon.pm',
	'PREREQ_PM'	=> {
    		'Test::More'	=> 0,
	},
	'test'		=> {
		'TESTS' 	=> 't/*.t */t/*.t'
	}
);
