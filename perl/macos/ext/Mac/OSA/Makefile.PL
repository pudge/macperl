use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> q(Mac::OSA),
    'LINKTYPE'		=> 'static dynamic',
    XSPROTOARG 		=> '-noprototypes', 		# XXX remove later?
	 TYPEMAPS   	=> '::Components:typemap',
    MACLIBS_SHARED	=> '"{{SharedLibraries}}"AppleScriptLib',   # e.g., '-lm' 
);
