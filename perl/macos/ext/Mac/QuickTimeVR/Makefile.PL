use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 TYPEMAPS   => '::Components:typemap ::Movies:typemap ::QuickDraw:typemap',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
   'LIBS'	=> ['"{{MWPPCLibraries}}"QuickTimeVRLib QTVRDummyCFM68KLib'],   # e.g., '-lm' 
);
