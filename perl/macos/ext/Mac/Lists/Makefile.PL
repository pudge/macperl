use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Controls:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
