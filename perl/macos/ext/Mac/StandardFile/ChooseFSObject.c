/**************************************************************************
Project	:	MacPerl	
File	:	ChooseFSObject.c	-	Choose File System Objects
Author	:	Thomas Wegner


Language	:	MPW C

$Log$


**************************************************************************/

#include <MacTypes.h>
#include <Files.h>
#include <ControlDefinitions.h>
#include <Dialogs.h>
#include <LowMem.h>
#include <StandardFile.h>
#include <GUSIFileSpec.h>
#include <string.h>


//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	Utilities
//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ


static ControlHandle GetDialogCtrl(DialogPtr dlg, short item)
{
	short 	kind;
	Handle	hdl;
	Rect	box;
	
	GetDialogItem(dlg, item, &kind, &hdl, &box);
	return (ControlHandle) hdl;
}



//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	 Standard File 
//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ


// volume vRefNum of the selected directory when we return from the Standard File dialog
static short 				currentVol;	
// directory parID of the selected directory when we return from the Standard File dialog
static long 				currentDir;	

static StandardFileReply	reply;		
static short				isAliasFlag	= 1 << 15;


// File filter proc for StdFChooseFolder
//
static pascal Boolean StdFFolderFFilter(CInfoPBPtr pb, Ptr DataPtr)
{
	return !(pb->hFileInfo.ioFlAttrib & ioDirMask);
}

// Dialog hook for StdFChooseFolder
// When our dialog hook is called, the StandardFileReply struct that we've passed to  
// Standard File has been filled in for the current selection. 
//
// Old IM Vol. IV, p. 75 and old Tech Note 80 give some hints about the low memory 
// globals SFSaveDisk and CurDirStore.
//
static pascal short StdFGetDirDlgHook(short item, DialogPtr dialog, Ptr DataPtr)
{
	switch (item) {
	
	case sfHookFirstCall:
		// specify where in the file system we open our dialog
		reply.sfFile.vRefNum = currentVol;
		reply.sfFile.parID = currentDir;
		reply.sfFile.name[0] = 0;
		return sfHookChangeSelection;
		
	case 10: 
		// <Directory> button		
		if ( reply.sfIsFolder || reply.sfIsVolume || (reply.sfFlags & isAliasFlag) ) {
			
			FSSpec dir = reply.sfFile;
			
			if (reply.sfFlags & isAliasFlag) {										
				// resolve that alias file, then we have its parent directory in parID
				// GUSIFSpResolve( &dir );
				Boolean 	targetIsFolder;
				Boolean		wasAliased;
				ResolveAliasFile( &dir, true, &targetIsFolder, &wasAliased);
			}
				
			// we need to move into the directory, to get its directory id, i.e. 
			// the parent directory (parID) of the empty file name
			GUSIFSpDown( &dir, "\p" );
				
			currentVol = dir.vRefNum;
			currentDir = dir.parID;	
			
			// fake Open button item number	
			return	sfItemOpenButton;
		}
		break;
	
	case 11: 
		// "Select Current Directory:" button
		
		currentVol = - ( LMGetSFSaveDisk() ); // access SFSaveDisk 
		currentDir = LMGetCurDirStore() ; // access CurDirStore
		
		// fake Open button item number
		return sfItemOpenButton;
	
	case sfHookNullEvent:
		if ( reply.sfIsFolder || reply.sfIsVolume || (reply.sfFlags & isAliasFlag) )
			// enable Directory button
			HiliteControl(GetDialogCtrl(dialog, 10), 0);
		else
			// disable Directory button
			HiliteControl(GetDialogCtrl(dialog, 10), 255);
		break;
	}
	
	return item;
}



//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	* StdFChooseFolder
//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	Choose a folder with Standard File
//

static pascal Boolean StdFChooseFolder(FSSpec * defaultSpec, FSSpec * result)
{
	Point 				where = {-1, -1};
	FSSpec				selFolder = {0, 0, "\p"};
	FileFilterYDUPP		fileFilterYDUPP;
	DlgHookYDUPP		dialogHookYDUPP;

	fileFilterYDUPP = NewFileFilterYDUPP( StdFFolderFFilter );
	dialogHookYDUPP = NewDlgHookYDUPP( StdFGetDirDlgHook );
	
	if (defaultSpec) {	
		GUSIFSpDown( defaultSpec, "\p" ); 
		
		currentVol = defaultSpec->vRefNum;
		currentDir = defaultSpec->parID;
	
	} else {
	
		currentVol = - ( LMGetSFSaveDisk() ); // access SFSaveDisk
		currentDir = LMGetCurDirStore(); // access CurDirStore			

	}
	
		
	CustomGetFile(
					fileFilterYDUPP,	// file filter
					-1,					// numTypes
					nil,				// typeList
					&reply,				// reply record
					193,				// dialog resource id
					where,				// where		
					dialogHookYDUPP,	// dialog hook
					nil,				// modal filter proc
					nil,				// active list
					nil,				// activate proc
					nil					// appl data pointer	
				);


	if (reply.sfGood) {				
		selFolder.vRefNum = currentVol;
		selFolder.parID = currentDir;
		
		*result = selFolder;
	
	}

	// dispose proc pointers
	DisposeFileFilterYDUPP( fileFilterYDUPP );
	DisposeDlgHookYDUPP( dialogHookYDUPP );

	return reply.sfGood;

}


// Simple dialog hook for StdFChooseFile 
//
static pascal short StdFInitDlgHook(short item, DialogPtr dialog, Ptr DataPtr)
{
	switch (item) {
	
	case sfHookFirstCall:
		// specify where in the file system we open our dialog
		reply.sfFile.vRefNum = currentVol;
		reply.sfFile.parID = currentDir;
		reply.sfFile.name[0] = 0;
		return sfHookChangeSelection;
	}
	
	return item;
}


//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	* StdFChooseFile
//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	Choose a file with Standard File
//
static pascal Boolean StdFChooseFile(FSSpec * defaultSpec, FSSpec * result)
{
	Point 			where = {-1, -1};
	DlgHookYDUPP	dialogHookYDUPP;

	dialogHookYDUPP = NewDlgHookYDUPP( StdFInitDlgHook );
	
	if (defaultSpec) {	
		GUSIFSpDown( defaultSpec, "\p" ); 
		
		currentVol = defaultSpec->vRefNum;
		currentDir = defaultSpec->parID;
	
	} else {
		
		currentVol = - ( LMGetSFSaveDisk() ); // access SFSaveDisk
		currentDir = LMGetCurDirStore(); // access CurDirStore				
	}
	
		
	CustomGetFile(
					nil,				// file filter
					-1,					// numTypes
					nil,				// typeList
					&reply,				// reply record
					-6042,				// standard dialog resource id
					where,				// where		
					dialogHookYDUPP,	// dialog hook
					nil,				// modal filter proc
					nil,				// active list
					nil,				// activate proc
					nil					// appl data pointer	
				);


	if (reply.sfGood) {				
		*result = reply.sfFile;
	}

	// dispose proc pointer
	DisposeDlgHookYDUPP( dialogHookYDUPP );

	return reply.sfGood;

}



//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	* StdFChooseFSObject
//ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
//	Choose a folder or file object with Standard File
//

pascal Boolean StdFChooseFSObject(char * path, Boolean folder, Boolean hasDefault)
{
	FSSpec 		defaultSpec;
	FSSpec 		result;
	Boolean		good;

	if (hasDefault)
		hasDefault = ( GUSIPath2FSp(path, &defaultSpec) == noErr );
	
	if (folder) 
	{
 		good = StdFChooseFolder( hasDefault ? &defaultSpec : nil, &result);
	}
	else 
	{
		good = StdFChooseFile( hasDefault ? &defaultSpec : nil, &result);
	}

	if (good)
		strcpy( path, GUSIFSp2FullPath(&result) );
	
	return good;
}
