use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::QuickDraw),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
