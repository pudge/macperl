use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Memory),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
