/*********************************************************************
Project	:	MacPerl			-	Standalone Perl
File		:	MemoryStream.h	-	Console interface for Perl handle based streams
Author	:	Matthias Neeracher
Language	:	MPW C/C++

$Log$
Revision 1.1  1997/06/23 17:11:15  neeri
Checked into CVS

*********************************************************************/


#ifdef __cplusplus
extern "C" {
#endif

void InstallMemConsole(Handle stdin, Handle stdout, Handle stderr);

#ifdef __cplusplus
}
#endif
