use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
    'LIBS'	=> ['"{{MWPPCLibraries}}"SpeechLib'],   # e.g., '-lm' 
);
