use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::DCon),
    'NAME'	=> 'Mac::DCon',
    'LIBS'  =>  [':DCon:Libraries:DConCWPPC.lib DConDummyCFM68KLib'],
	'INC' 	=> "-i :DCon:Headers"
);
