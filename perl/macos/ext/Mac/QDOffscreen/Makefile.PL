use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::QDOffscreen),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
