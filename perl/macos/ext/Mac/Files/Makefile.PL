use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Files),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
