use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Events:typemap ::Files:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
