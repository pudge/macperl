use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::Navigation),
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => 'typemap ::Events:typemap ::Files:typemap ::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
   'LIBS'	=> ['"{{MW68KLibraries}}"NavigationLib "{{MWPPCLibraries}}"NavigationLib'],   # e.g., '-lm' 
);
