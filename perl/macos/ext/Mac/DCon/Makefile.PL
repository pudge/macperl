use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'	=> 'Mac::DCon',
    'LIBS'  =>  [':DCon:Libraries:DConCWPPC.lib DConDummyCFM68KLib'],
	'INC' 	=> "-i :DCon:Headers"
);
