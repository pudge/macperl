use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Notification),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => 'typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
