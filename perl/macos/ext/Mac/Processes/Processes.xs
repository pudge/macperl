/* $Header$
 *
 *    Copyright (c) 1996 Matthias Neeracher
 *
 *    You may distribute under the terms of the Perl Artistic License,
 *    as specified in the README file.
 *
 * $Log$
 * Revision 1.2  1997/11/18 00:53:10  neeri
 * MacPerl 5.1.5
 *
 * Revision 1.1  1997/04/07 20:50:30  neeri
 * Synchronized with MacPerl 5.1.4a1
 *
 */

#define MAC_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <Types.h>
#include <Memory.h>
#include <Processes.h>
#include <TFileSpec.h>

typedef LaunchPBPtr			LaunchParam;
typedef ProcessInfoRecPtr	ProcessInfo;

static ProcessInfo NewProcessInfo()
{
	ProcessInfo	pi;
	pi = (ProcessInfo) malloc(sizeof(ProcessInfoRec)+sizeof(FSSpec)+36);
	pi->processInfoLength	=	sizeof(ProcessInfoRec);
	pi->processName			=	(StringPtr)((char *)pi+sizeof(ProcessInfoRec));
	pi->processAppSpec		=	(FSSpecPtr)((char *)pi+sizeof(ProcessInfoRec)+36);
	
	return pi;
}

MODULE = Mac::Processes	PACKAGE = LaunchParam

=head2 LaunchParam

This Perl hash maps onto the fields of a Launch Parameter Block 
I<(Consult the manual)>.

The fields are: 

	launchFileFlags
	launchControlFlags
	launchAppSpec
	launchAvailableSize
	launchProcessSN
	launchPreferredSize
	launchMinimumSize

=cut

STRUCT * LaunchParam
	U16						launchFileFlags;
	U16						launchControlFlags;
	FSSpecPtr				launchAppSpec;
	ProcessSerialNumber		launchProcessSN;
	U32						launchPreferredSize;
	U32						launchMinimumSize;
	U32						launchAvailableSize;

=item new LaunchParam [ARGUMENTS]

Returns LaunchParam.

	$launch = 
		new LaunchParam(
			launchAppSpec => "volume:apps:myapp", launchMinimumSize => 32000);

=cut
LaunchParam
_new()
	CODE:
	RETVAL = (LaunchParam) malloc(sizeof(LaunchParamBlockRec)+sizeof(FSSpec));
	RETVAL->launchBlockID			=	extendedBlock;
	RETVAL->launchEPBLength			=	extendedBlockLen;
	RETVAL->launchAppSpec			=	(FSSpecPtr)((char *)RETVAL+sizeof(LaunchParamBlockRec));
	RETVAL->launchAppParameters	=	nil;
	OUTPUT:
	RETVAL

=item DESTROY LPB

=cut
void
DESTROY(lpb)
	LaunchParam	lpb
	CODE:
	free(lpb);


MODULE = Mac::Processes	PACKAGE = ProcessInfo

=head2 ProcessInfo

This Perl hash allows access to the C<ProcessInfo> structure.
B<(Consult your manual)>.

The field names are: 

	processName
	processNumber
	processType
	processSignature
	processSize
	processMode
	processLocation
	processLauncher
	processLaunchDate
	processActiveTime
	processAppSpec

=cut

STRUCT * ProcessInfo
	Str255				processName;
	ProcessSerialNumber	processNumber;
	U32					processType;
	OSType				processSignature;
	U32					processMode;
	Ptr					processLocation;
	U32					processSize;
	U32					processFreeMem;
	ProcessSerialNumber	processLauncher;
	U32					processLaunchDate;
	U32					processActiveTime;
	FSSpecPtr			processAppSpec;

=item DESTROY PI

=cut
void
DESTROY(pi)
	ProcessInfo	pi
	CODE:
	free(pi);

MODULE = Mac::Processes	PACKAGE = Mac::Processes

=head2 Functions

=item LaunchApplication LAUNCHPARAMS

The LaunchApplication function launches the application from the specified file
and returns the process serial number, preferred partition size, and minimum
partition size if the application is successfully launched.
Returns zero on failure.

=cut
MacOSRet
LaunchApplication(LaunchParams)
	LaunchParam LaunchParams

=item LaunchDeskAccessory PFILESPEC, PDANAME

The LaunchDeskAccessory function searches the resource fork of the file specified
by the pFileSpec parameter for the desk accessory with the 'DRVR' resource name
specified in the pDAName parameter. If the 'DRVR' resource name is found,
LaunchDeskAccessory launches the corresponding desk accessory. If the desk
accessory is already open, it is brought to the front.
Returns zero on failure.

=cut
MacOSRet
LaunchDeskAccessory(pFileSpec, pDAName)
	SV *		pFileSpec
	Str255	pDAName
	PREINIT:
	FSSpec	spec;
	FSSpec *	fssp = nil;
	CODE:
	if (SvTRUE(pFileSpec) && Path2FSSpec(SvPV(pFileSpec,na), &spec))
		fssp = &spec;
	RETVAL = LaunchDeskAccessory(fssp, pDAName);
	OUTPUT:
	RETVAL

=item GetCurrentProcess

The GetCurrentProcess function returns the process serial
number of the process that is currently running, that is, the one currently
accessing the CPU.
Return C<undef> if an error was detected.

=cut
ProcessSerialNumber
GetCurrentProcess()
	CODE:
	if (gLastMacOSErr = GetCurrentProcess(&RETVAL)) {
		XSRETURN_UNDEF;
	}
	OUTPUT:
	RETVAL
	
=item GetFrontProcess

The GetFrontProcess function returns the process serial
number of the process running in the foreground.
Return C<undef> if an error was detected.

=cut
ProcessSerialNumber
GetFrontProcess()
	CODE:
	if (gLastMacOSErr = GetFrontProcess(&RETVAL)) {
		XSRETURN_UNDEF;
	}
	OUTPUT:
	RETVAL
	
=item GetNextProcess PSN

Get information about the next process, if any, in the Process Manager’s internal
list of open processes.
Return C<undef> if an error was detected.

=cut
ProcessSerialNumber
GetNextProcess(PSN)
	ProcessSerialNumber	PSN
	CODE:
	if (gLastMacOSErr = GetNextProcess(&PSN)) {
		XSRETURN_UNDEF;
	} else
		RETVAL = PSN;
	OUTPUT:
	RETVAL
	
=item GetProcessInformation PSN

The GetProcessInformation function returns, in a process information record,
information about the specified process. The information returned in the info
parameter includes the application’s name as it appears in the Application menu,
the type and signature of the application, the address of the application
partition, the number of bytes in the application partition, the number of free
bytes in the application heap, the application that launched the application, the
time at which the application was launched, and the location of the application
file.
Return C<undef> if an error was detected.

=cut
ProcessInfo
GetProcessInformation(PSN)
	ProcessSerialNumber	PSN
	CODE:
	RETVAL = NewProcessInfo();
	if (gLastMacOSErr = GetProcessInformation(&PSN, RETVAL)) {
		free(RETVAL);
		XSRETURN_UNDEF;
	} 
	OUTPUT:
	RETVAL
	
=item SetFrontProcess PSN

The SetFrontProcess function schedules the specified process to move to the
foreground. The specified process moves to the foreground after the current
foreground process makes a subsequent call to WaitNextEvent or EventAvail.
Returns zero on failure.

=cut
MacOSRet
SetFrontProcess(PSN)
	ProcessSerialNumber	&PSN

=item WakeUpProcess PSN

The WakeUpProcess function makes a process suspended by WaitNextEvent() eligible to
receive CPU time. A process is suspended when the value of the sleep parameter in
the WaitNextEvent() function is not 0 and no events for that process are pending in
the event queue. This process remains suspended until the time specified in the
sleep parameter expires or an event becomes available for that process. You can
use WakeUpProcess to make the process eligible for execution before the time
specified in the sleep parameter expires.
Returns zero on failure.

=cut
MacOSRet
WakeUpProcess(PSN)
	ProcessSerialNumber	&PSN

=item SameProcess PSN1, PSN2

The SameProcess function compares two process serial numbers and determines
whether they refer to the same process.
Return C<undef> if an error was detected.

=cut
Boolean
SameProcess(PSN1, PSN2)
	ProcessSerialNumber	PSN1
	ProcessSerialNumber	PSN2
	CODE:
	if (gLastMacOSErr = SameProcess(&PSN1, &PSN2, &RETVAL)) {
		XSRETURN_UNDEF;
	} 
	OUTPUT:
	RETVAL

=item ExitToShell

This function is not implemented: ExitToShell() unsupported. Use exit.

=cut
void
ExitToShell()
	CODE:
	croak("ExitToShell() unsupported. Use exit.");

=back

=cut
