/*********************************************************************
Project	:	MacPerl			-	Standalone Perl
File		:	MPAEVTStream.h	-	I/O streams through AppleEvents
Author	:	Matthias Neeracher
Language	:	MPW C/C++

$Log$
Revision 1.1  1997/06/23 17:10:31  neeri
Checked into CVS

*********************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

#include <AppleEvents.h>

pascal OSErr Relay(const AppleEvent * inData, AppleEvent * outData, long refCon);
pascal void  FlushAEVTs(AppleEvent * outData);

#ifdef __cplusplus
}
#endif
