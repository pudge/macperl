use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> q(Mac::Sound),
    'LINKTYPE'		=> 'static dynamic',
	 TYPEMAPS   	=> '::QuickDraw:typemap',
    XSPROTOARG 		=> '-noprototypes', 		# XXX remove later?
   'MACLIBS_SHARED'	=> '"{{SharedLibraries}}"SoundLib',   # e.g., '-lm' 
);
