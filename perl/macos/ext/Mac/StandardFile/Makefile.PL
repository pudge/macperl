use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::StandardFile),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Events:typemap ::Files:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
