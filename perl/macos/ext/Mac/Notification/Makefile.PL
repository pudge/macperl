use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => 'typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
