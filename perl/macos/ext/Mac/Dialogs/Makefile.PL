use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Controls:typemap ::Events:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
