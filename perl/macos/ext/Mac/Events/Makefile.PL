use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Events),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
