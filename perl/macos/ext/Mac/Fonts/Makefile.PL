use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Fonts),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
