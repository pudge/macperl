use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Controls),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
