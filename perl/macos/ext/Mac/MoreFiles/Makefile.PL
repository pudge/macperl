use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::MoreFiles),
    'LINKTYPE' => ['static', 'dynamic'],
    XSPROTOARG 	=> '-noprototypes', 		# XXX remove later?
	 'INC'		=> '-i "$(PERL_SRC):MoreFiles:C Headers:"',
	OBJECT		=> 'MF.c'
);
