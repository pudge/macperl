use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> q(Mac::Speech),
    'LINKTYPE'		=> 'static dynamic',
    XSPROTOARG 		=> '-noprototypes', 		# XXX remove later?
    MACLIBS_SHARED	=> '"{{SharedLibraries}}"SpeechLib',   # e.g., '-lm' 
);
