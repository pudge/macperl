use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Menus),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
