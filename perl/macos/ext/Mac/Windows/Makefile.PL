use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Windows),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Controls:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
