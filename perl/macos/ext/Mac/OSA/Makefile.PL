use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
	 TYPEMAPS   => '::Components:typemap',
    'LIBS'	=> ['"{{MW68KLibraries}}"AppleScriptLib "{{MWPPCLibraries}}"AppleScriptLib'],   # e.g., '-lm' 
);
