use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Types),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
