use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
   'LIBS'	=> ['"{{MWPPCLibraries}}"SoundLib'],   # e.g., '-lm' 
);
