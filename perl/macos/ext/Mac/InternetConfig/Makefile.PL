use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
    XSPROTOARG => '-noprototypes', 		# XXX remove later?
	 'LIBS'     => '"$(IC)"ICGlueCFM-68K.Lib "$(IC)"ICGlueCFM-PPC.Lib',
	'OBJECT'   => 'InternetConfig.c'
);
