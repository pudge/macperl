use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Dialogs),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap ::Controls:typemap ::Events:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
);
