use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Gestalt),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
