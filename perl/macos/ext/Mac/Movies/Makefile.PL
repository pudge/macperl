use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::Components:typemap ::Events:typemap ::QuickDraw:typemap ::QDOffscreen:typemap ::Menus:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
   'LIBS'	=> ['"{{MW68KLibraries}}"QuickTimeLib "{{MWPPCLibraries}}"QuickTimeLib'],   # e.g., '-lm' 
);
