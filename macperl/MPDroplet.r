/*********************************************************************
Project	:	MacPerl			-	Real Perl Application
File		:	MPDroplet.r		-	Resources for droplets
Authors	:	Matthias Neeracher & Tim Endres
Language	:	MPW C

$Log$
Revision 1.1  1997/06/23 17:10:38  neeri
Checked into CVS

*********************************************************************/

#define SystemSevenOrLater 1

#include "Types.r"
#include "SysTypes.r"

#include "MPExtension.r"

include "MPDroplet.code" 'CODE' as 'MrPC';
include "MPDroplet.code" 'DATA' as 'MrPD';

include "MPExtension.rsrc" 'BNDL'(128) as 'MrPB'(128);
include "MPExtension.rsrc" 'MrPL'(0);
include "MPExtension.rsrc" 'ICN#'(128);
include "MPExtension.rsrc" 'icl4'(128);
include "MPExtension.rsrc" 'icl8'(128);
include "MPExtension.rsrc" 'ics#'(128);
include "MPExtension.rsrc" 'ALRT'(4096);
include "MPExtension.rsrc" 'DITL'(4096);
include "MPExtension.rsrc" 'FREF'(128);
include "MPExtension.rsrc" 'FREF'(129);
include "MPExtension.rsrc" 'FREF'(130);
include "MPExtension.rsrc" 'FREF'(131);
include "MPExtension.rsrc" 'FREF'(132);

resource 'STR ' (SERsrcBase) {
	"Droplet"
};

resource 'McPp' (SERsrcBase) {
	'SCPT', 'APPL', 'MrPL', wantsBundle, noCustomIcon
};

resource 'McPs' (SERsrcBase) {
	{
		'MrPC', 'CODE',    0,    0,
		'MrPC', 'CODE',    1,    1,
		'MrPC', 'CODE',    2,    2,
		'MrPD', 'DATA',    0,    0,
		'MrPB', 'BNDL',  128,  128,
		'MrPL', 'MrPL',    0,    0,
		'SIZE', 'SIZE',  128,   -1,
		'ICN#', 'ICN#',  128,  128,
		'icl4', 'icl4',  128,  128,
		'icl8', 'icl8',  128,  128,
		'ics#', 'ics#',  128,  128,
		'ALRT', 'ALRT', 4096, 4096,
		'DITL', 'DITL', 4096, 4096,
		'FREF', 'FREF',  128,  128,
		'FREF', 'FREF',  129,  129,
		'FREF', 'FREF',  130,  130,
		'FREF', 'FREF',  131,  131,
		'FREF', 'FREF',  132,  132,
		    0,      0,     0,    0
	}
};

resource 'SIZE' (128) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,
	multiFinderAware,
	backgroundAndForeground,
	dontGetFrontClicks,
	ignoreChildDiedEvents,
	is32BitCompatible,
	isHighLevelEventAware,
	localAndRemoteHLEvents,
	reserved,
	reserved,
	reserved,
	reserved,
	reserved,
	65536,
	65536
};
