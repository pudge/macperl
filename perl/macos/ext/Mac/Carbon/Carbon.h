/* $Header$
 *
 *    Copyright (c) 2002 Matthias Neeracher, Chris Nandor
 *
 *    You may distribute under the terms of the Perl Artistic License,
 *    as specified in the README file.
 *
 * $Log$
 * Revision 1.6  2002/12/17 16:18:37  pudge
 * Use new constant
 *
 * Revision 1.5  2002/12/12 15:36:26  pudge
 * Make work with gcc2
 *
 * Revision 1.4  2002/12/12 14:57:08  pudge
 * Update POD and docs
 *
 * Revision 1.3  2002/12/10 01:47:17  pudge
 * Some cleanup, and add idle proc, which we don't actually use
 *
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

// keyReplyPortAttr is not found on some Mac OS X versions ...
// so define our own.  nyah nyah.
#define keyPerlReplyPortAttr 'repp'

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
 *   * Can only handle 31 characters ... yes, that sucks
 *   * Probably bugs to fix ...
 *
 */


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
static OSErr GUSIFSpDown(FSSpec * spec, ConstStr31Param name)
{
	CInfoPBRec *	pb      = malloc(sizeof(CInfoPBRec));
	UInt8 *		path    = malloc(2*PATH_MAX); // to be safe

	pb->dirInfo.ioVRefNum   = spec->vRefNum;
	pb->dirInfo.ioDrDirID   = spec->parID;
	pb->dirInfo.ioNamePtr   = spec->name;
	pb->dirInfo.ioFDirIndex = 0;

	gMacPerl_OSErr = PBGetCatInfoSync(pb);

	if (!gMacPerl_OSErr) {
		MacPerl_CopyC2P(name, path);
		gMacPerl_OSErr = FSMakeFSSpec(
			pb->dirInfo.ioVRefNum, pb->dirInfo.ioDrDirID, path, spec
		);
	}

	free(pb);
	free(path);

	return gMacPerl_OSErr;
}


/* Returns full POSIX-style path from FSSpec */
/* Returns empty string on failure, sets gMacPerl_OSErr to nonzero */
static char * GUSIFSp2FullPath(const FSSpec * spec)
{
	FSRef		ref;
	char *		name     = malloc(255);
	UInt8 *		path     = malloc(2*PATH_MAX); // to be safe
	UInt32		pathSize = 2*PATH_MAX;

	// If file doesn't exist, see if dir does
	*name = 0;
	if ( (gMacPerl_OSErr = FSpMakeFSRef(spec, &ref)) && (gMacPerl_OSErr == fnfErr) ) {
		FSSpec *	spec2 = malloc(sizeof(FSSpec));

		spec2->vRefNum = spec->vRefNum;
		spec2->parID   = spec->parID;
		spec2->name[0] = 0;

		if ( gMacPerl_OSErr = GUSIFSpUp(spec2) ) {
			free(name);
			free(spec2);
			return "";
		}

		if ( gMacPerl_OSErr = FSpMakeFSRef(spec2, &ref) ) {
			free(name);
			free(spec2);
			return "";
		} else {
			strncpy(name, spec->name+1, *spec->name);
			name[*spec->name] = 0;
			free(spec2);
		}
	}

	if (gMacPerl_OSErr = FSRefMakePath(&ref, path, pathSize)) {
		path = "";
	} else if (*name != 0) {
		sprintf(path, "%s/%s", path, name);
	}

	free(name);

	return (char *)path;
}

/* Returns FSSpec from POSIX-style path, relative or absolute */
/* or from GUSI-style FSSpec encoding (see GUSIFSp2Encoding) */
static OSErr GUSIPath2FSp(const char * fileName, FSSpec * spec)
{
	FSRef		ref;
	char *		name = malloc(255);

	// convert from GUSI-style FSSpec encoding (see GUSIFSp2Encoding)
	if (*fileName == '\021' && fileName[13] == ':') {
		Str255	path;

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

		MacPerl_CopyC2P(fileName, path);

 		switch (gMacPerl_OSErr = FSMakeFSSpec(spec->vRefNum, spec->parID, path, spec)) {
		 	case fnfErr: // It is OK if file does not exist
		 		free(name);
				gMacPerl_OSErr = noErr;
 		 		return gMacPerl_OSErr;
			default:
		 		free(name);
				return gMacPerl_OSErr;
		}
	}

	// If file doesn't exist, see if dir does
	*name = 0;
	if ( (gMacPerl_OSErr = FSPathMakeRef((UInt8 *)fileName, &ref, NULL)) && (gMacPerl_OSErr == fnfErr) ) {
		char * fileNameCpy	= malloc(strlen(fileName));

		strcpy(fileNameCpy, fileName);

		if ( !(name = rindex(fileNameCpy, '/')) ) {
			sprintf(fileNameCpy, "./%s", fileName);
			name = rindex(fileNameCpy, '/');

		} else if ( name && *name != 0 && name[1] == 0 ) {
			fileNameCpy[name - fileNameCpy] = 0;
			if (! (name = rindex(fileNameCpy, '/')) ) {
				char * fileNameCpy2	= malloc(strlen(fileName));

				strcpy(fileNameCpy2, fileNameCpy);
				sprintf(fileNameCpy, "./%s", fileNameCpy2);
				name = rindex(fileNameCpy, '/');

				free(fileNameCpy2);
			}
		}

		if ( name && *name != 0 ) {
			char * dir		= malloc(PATH_MAX);

			strncpy(dir, fileNameCpy, (name - fileNameCpy));
			dir[name - fileNameCpy] = 0;
			name++;
			gMacPerl_OSErr = FSPathMakeRef((UInt8 *)dir, &ref, NULL);
			free(dir);
			free(fileNameCpy);
			if (gMacPerl_OSErr) {
		 		free(name);
				return gMacPerl_OSErr;
			}
		}
		free(fileNameCpy);
	}

	// get FSSpec
	gMacPerl_OSErr = FSGetCatalogInfo(&ref, kFSCatInfoNone, NULL, NULL, spec, NULL);
	if ( !gMacPerl_OSErr && *name != 0 )
		gMacPerl_OSErr = GUSIFSpDown(spec, name);

	return gMacPerl_OSErr;
}

/* This returns the GUSI-specific text representation of an FSSpec */
static char * GUSIFSp2Encoding(const FSSpec * spec)
{
	char * realSpec = malloc(255);
	char fmt[32];

	sprintf(fmt, "\021%%04hX%%08X:%%%d.%ds", *spec->name, *spec->name);
	sprintf(realSpec, fmt, spec->vRefNum, spec->parID, spec->name+1);

	return realSpec;
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
	FSSpec * spec = malloc(sizeof(FSSpec));

	if ((gMacPerl_OSErr = GUSIPath2FSp(path, spec)) == 0) {
		if ((gMacPerl_OSErr = FSpGetFInfo(spec, &info)) == 0) {
			info.fdType 	= type;
			info.fdCreator	= creator;
			info.fdFlags	&= ~kHasBeenInited;

			gMacPerl_OSErr = FSpSetFInfo(spec, &info);
		}
	}

	free(spec);
}

static void fgetfileinfo(char * path, OSType * creator, OSType * type)
{
	FInfo info;
	FSSpec * spec = malloc(sizeof(FSSpec));

	if ((gMacPerl_OSErr = GUSIPath2FSp(path, spec)) == 0) {
		if ((gMacPerl_OSErr = FSpGetFInfo(spec, &info)) == 0) {
			if (creator)
				*creator = info.fdCreator;
			if (type)
				*type    = info.fdType;
		}
	}

	free(spec);
}

#  endif /* MACOS_TRADITIONAL */

#endif /* _MAC_CARBON_H */
