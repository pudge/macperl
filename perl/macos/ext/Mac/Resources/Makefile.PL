use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Resources),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
