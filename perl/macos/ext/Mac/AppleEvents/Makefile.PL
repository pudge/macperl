use ExtUtils::MakeMaker;

WriteMakefile(
    'LINKTYPE'	=> 'static dynamic',
	 'LIBS'     => '"$(AEGizmos)AEGizmos4Perl.Lib.CFM68K" "$(AEGizmos)AEGizmos4Perl.Lib.PPC" ',
	 'OBJECT'   => 'AppleEvents.c.o PerlAEUtils.cp.o'
);
