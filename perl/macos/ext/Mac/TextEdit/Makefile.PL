use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::TextEdit),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
