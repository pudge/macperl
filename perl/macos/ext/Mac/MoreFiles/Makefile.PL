use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::MoreFiles),
    'LINKTYPE' => ['static', 'dynamic'],
    XSPROTOARG 	=> '-noprototypes', 		# XXX remove later?
	 'INC'		=> '-i "$(PERL_SRC):MoreFiles:CHeaders:"',
	OBJECT		=> 'MF.c'
);
