use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> q(Mac::SAT),
    'NAME'	=> 'Mac::SAT',
    'LIBS'  =>  [':SAT:lib:SAT(PPC).lib SATDummyCFM68KLib'],
	 TYPEMAPS   => '::QuickDraw:typemap',
	'INC' 	=> "-i :SAT:include"
);
