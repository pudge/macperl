/* $Header$
 *
 *    Copyright (c) 2002 Matthias Neeracher, Chris Nandor
 *
 *    You may distribute under the terms of the Perl Artistic License,
 *    as specified in the README file.
 *
 * $Log$
 * Revision 1.2  2002/11/14 12:47:58  pudge
 * Cast errno to short
 *
 * Revision 1.1  2002/11/13 02:04:50  pudge
 * Aieeeeee!  Big ol' Carbon update.
 *
 *
 */

#ifndef _MAC_CARBON_H
#define _MAC_CARBON_H

#  ifndef MACOS_TRADITIONAL /* ignore for Mac OS ... Mac OS X only */
#    ifdef MAC_CONTEXT

/* Perl defines Move too */
#undef Move
#include <Events.h>
#include <Dialogs.h>
#include <Files.h>
#include <Types.h>
#include <ConditionalMacros.h>

typedef OSErr	MacOSRet;
typedef Handle	HandleRet;
typedef Ptr	RawPtr;
typedef Ptr	PtrRet;

#    endif /* MAC_CONTEXT */

#define XS_PUSH_SHORT(ARG) ++sp;\
    *sp = sv_newmortal();\
    sv_setiv(*sp, (IV)(ARG) )

#define XS_PUSH_OSTYPE(ARG) ++sp;\
    *sp = sv_newmortal();\
    sv_setpvn(*sp, (char *) &(ARG), 4)

#define XS_PUSH_STR255(ARG)  ++sp;\
    *sp = sv_newmortal();\
    sv_setpvn(*sp, ((char *) (ARG)) + 1, (ARG)[0])

#include <sys/types.h>
#include <stdlib.h>
#include <limits.h>
#include <errno.h>

/* $! and $^E will both be set together, which is fine (for now?) */
#define gMacPerl_OSErr (short)errno

/* c string to pascal string */
static StringPtr MacPerl_CopyC2P(const char * c, StringPtr p)
{
	memcpy(p+1, c, *p = strlen(c));
	
	return p;
}

/* used by GUSIPath2FSp to decode a GUSIFSp2Encoding-ized FSSpec */
static bool ReadHex(const char * path, int bytes, char * result) 
{
	char hexbyte[3];
	hexbyte[2] = 0;
	while (bytes--) {
		hexbyte[0] = *path++; hexbyte[1] = *path++;
		if (isxdigit(hexbyte[0]) && isxdigit(hexbyte[1])) {
			*result++ = (char) strtol(hexbyte, nil, 16);
		} else {
			return false;
		}
	}
	return true;
}


/*   Mac OS and Unix have different epochs (see perlport).
 *   Mac OS is seconds since midnight Jan 1 1904 local time,
 *   Unix is   seconds since midnight Jan 1 1970 UTC.
 *
 *   These routines convert between the two, using Carbons
 *   calls to convert between local time and UTC (taking
 *   TZ and DST into account), and then adjusting with the
 *   known offset constant.
 */

#define MACOS_OFFSET 2082844800

static UInt32 SecondsMac2Unix(UInt32 macseconds)
{
	UInt32 unixseconds;

	ConvertLocalTimeToUTC(macseconds, &unixseconds);
	unixseconds -= MACOS_OFFSET;

	return unixseconds;
}


static UInt32 SecondsUnix2Mac(UInt32 unixseconds)
{
	UInt32 macseconds;

	unixseconds += MACOS_OFFSET;
	ConvertUTCToLocalTime(unixseconds, &macseconds);

	return macseconds;
}


/*   GUSI replacement routines.  Currently, we use FS* functions
 *   to convert FSRefs to and from paths and FSSpecs, which works
 *   nicely, except that it only works for existing files.
 *
 *   There is plenty of room for improvement:
 *
 *   * Better error handling for odd cases
 *   * Alias resolving?  Is that even necessary?
 *   * Using FSRef routines apparently means it is harder to allow
 *     use of filenames that don't exist ... do we care?  Maybe for FindFolder() ...
 *   * Probably bugs to fix ...
 *
 */


/* Returns full POSIX-style path from FSSpec */
/* Returns empty string on failure, sets gMacPerl_OSErr to nonzero */
static char * GUSIFSp2FullPath(const FSSpec * spec)
{
	FSRef		ref;
	UInt8 *		path     = (UInt8 *)NewPtr(2*PATH_MAX); // to be safe
	UInt32		pathSize = 2*PATH_MAX;

	if ( (gMacPerl_OSErr = FSpMakeFSRef(spec, &ref)) ) { // && (gMacPerl_OSErr != fnfErr) )
		return "";
	}

	if (gMacPerl_OSErr = FSRefMakePath(&ref, path, pathSize))
		return "";

	return (char *)path;
}

/* Returns FSSpec from POSIX-style path, relative or absolute */
/* or from GUSI-style FSSpec encoding (see GUSIFSp2Encoding) */
static OSErr GUSIPath2FSp(const char * fileName, FSSpec * spec)
{
	FSRef		ref;

	// convert from GUSI-style FSSpec encoding (see GUSIFSp2Encoding)
	if (*fileName == '\021' && fileName[13] == ':') {
		spec->vRefNum 	= 0;
		spec->parID	= 0;

		if (
			!ReadHex(fileName+1, 2, (char *)&spec->vRefNum) || !ReadHex(fileName+5, 4, (char *)&spec->parID)
		) {
			spec->vRefNum = 0;
			spec->parID   = 0;
		} else {
			fileName += 13;
		}

		Str255	path;
		MacPerl_CopyC2P(fileName, path);

 		switch (gMacPerl_OSErr = FSMakeFSSpec(spec->vRefNum, spec->parID, path, spec)) {
		 	case fnfErr: // It is OK if file does not exist
				gMacPerl_OSErr = noErr;
 		 		return gMacPerl_OSErr;
			default:
				return gMacPerl_OSErr;
		}
	}

	if (gMacPerl_OSErr = FSPathMakeRef((UInt8 *)fileName, &ref, NULL))
		return gMacPerl_OSErr;

	gMacPerl_OSErr = FSGetCatalogInfo(&ref, kFSCatInfoNone, NULL, NULL, spec, NULL);
	return gMacPerl_OSErr;
}

/* This returns the GUSI-specific text representation of an FSSpec */
static char * GUSIFSp2Encoding(const FSSpec * spec)
{
	char * realSpec = NewPtr(255);
	char fmt[32];

	sprintf(fmt, "\021%%04hX%%08X:%%%d.%ds", *spec->name, *spec->name);
	sprintf(realSpec, fmt, spec->vRefNum, spec->parID, spec->name+1);

	return realSpec;
}

/* This returns an FSSpec of the directory enclosing the given FSSpec */
static OSErr GUSIFSpUp(FSSpec * spec)
{
	if (spec->parID == fsRtParID) {
		spec->vRefNum = 666;
		spec->parID   = 0;
		spec->name[0] = 0;
	} else {
		if (1) { // CatInfo(-1)
			gMacPerl_OSErr = FSMakeFSSpec(
				spec->vRefNum, spec->parID, NULL, spec
			);
		}
	}

	return gMacPerl_OSErr;
}

/* This returns an FSSpec of the named file in the directory in the given FSSpec */
/* untested!! */
static OSErr GUSIFSpDown(FSSpec * spec, ConstStr31Param name)
{
	gMacPerl_OSErr = FSMakeFSSpec(
		spec->vRefNum, spec->parID, name, spec
	);

	return gMacPerl_OSErr;
}

/* Finds special folders */
static OSErr GUSISpecial2FSp(OSType object, short vol, FSSpec * desc)
{
	if (gMacPerl_OSErr = FindFolder(vol, object, true, &desc->vRefNum, &desc->parID))
		return gMacPerl_OSErr;

	return GUSIFSpUp(desc);
}



static void fsetfileinfo(char * path, OSType creator, OSType type)
{
	FInfo info;
	FSSpec * spec = (FSSpec *)NewPtr(sizeof(FSSpec));

	if ((gMacPerl_OSErr = GUSIPath2FSp(path, spec)) == 0) {
		if ((gMacPerl_OSErr = FSpGetFInfo(spec, &info)) == 0) {
			info.fdType 	= type;
			info.fdCreator	= creator;
			info.fdFlags	&= ~kHasBeenInited;

			gMacPerl_OSErr = FSpSetFInfo(spec, &info);
		}
	}
	DisposePtr((char *)spec);
}

static void fgetfileinfo(char * path, OSType * creator, OSType * type)
{
	FInfo info;
	FSSpec * spec = (FSSpec *)NewPtr(sizeof(FSSpec));

	if ((gMacPerl_OSErr = GUSIPath2FSp(path, spec)) == 0) {
		if ((gMacPerl_OSErr = FSpGetFInfo(spec, &info)) == 0) {
			if (creator)
				*creator = info.fdCreator;
			if (type)
				*type    = info.fdType;
		}
	}
	DisposePtr((char *)spec);
}

/* Maybe we'll have use for this again? *
* 
* static pascal Boolean SubLaunchIdle(EventRecord * ev, long * sleep, RgnHandle * rgn)
* {
* 	// printf("%d : %d : %d : %d\n", kHighLevelEvent, ev->what, sleep, rgn);
* 	switch (ev->what) {
* 		case kHighLevelEvent:
* 			AEProcessAppleEvent(ev);
* 			return true;
* 		default:
* 			break;
* 	}		
* 
* 	*sleep = 0;
* 	rgn = nil;
* 	return false;
* }
*/

//#define uSubLaunchIdle *(AEIdleUPP)&SubLaunchIdle

#  endif /* MACOS_TRADITIONAL */

#endif /* _MAC_CARBON_H */
