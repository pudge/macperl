use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> q(Mac::AppleEvents),
    'LINKTYPE'		=> 'static dynamic',
	 'MACLIBS_PPC'  => '"::::::AEGizmos:AEGizmos4Perl.Lib.PPC" ',
	 'OBJECT'   	=> 'AppleEvents.c.o PerlAEUtils.cp.o',
	 'INC'			=> '-i $(PERL_SRC):AEGizmos:Headers:'
);
