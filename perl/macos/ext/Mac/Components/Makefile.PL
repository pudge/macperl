use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Components),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
