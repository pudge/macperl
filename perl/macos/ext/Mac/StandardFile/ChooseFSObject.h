/**************************************************************************
Project	:	MacPerl	
File	:	ChooseFSObject.h	-	Choose File System Objects
Author	:	Thomas Wegner


Language	:	MPW C

$Log$


**************************************************************************/

#ifndef __CHOOSEFSOBJECT__
#define __CHOOSEFSOBJECT__

#include <MacTypes.h>
#include <Files.h>

//	Choose a folder or file object with Standard File
pascal Boolean StdFChooseFSObject(char * path, Boolean folder, Boolean hasDefault);


#endif /* __CHOOSEFSOBJECT__ */
