use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Lists),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Controls:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
