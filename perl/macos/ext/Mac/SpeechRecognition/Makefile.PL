use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> q(Mac::SpeechRecognition),
    'LINKTYPE'		=> 'static dynamic',
    XSPROTOARG 		=> '-noprototypes', 		# XXX remove later?
    MACLIBS_SHARED	=> '"{{SharedLibraries}}"SpeechRecognitionLib',   # e.g., '-lm' 
);
