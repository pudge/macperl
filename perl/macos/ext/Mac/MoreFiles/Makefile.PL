use ExtUtils::MakeMaker;

WriteMakefile(
	'NAME'     => 'Mac::MoreFiles',
    'LINKTYPE' => ['static', 'dynamic'],
    'LIBS'	=> ['"{{MWPPCLibraries}}"PLStringFuncsPPC.lib'],   # e.g., '-lm' 
	'OBJECT'   => 'MF.c DirectoryCopy.c FileCopy.c FSpCompat.c FullPath.c IterateDirectory.c MoreDesktopMgr.c MoreFiles.c MoreFilesExtras.c Search.c'
);
