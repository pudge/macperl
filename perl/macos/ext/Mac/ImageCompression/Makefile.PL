use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::ImageCompression),
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
