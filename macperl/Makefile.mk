#######################################################################
# Project	: MacPerl		-
# File		: Makefile.mk	-	dmake Makefile for MacPerl
# Author	: Matthias Neeracher
# Language	: MPW Shell/Make
#
#  $Log$
#  Revision 1.4  2000/12/29 00:30:16  pudge
#  Temporary change for my setup
#
#  Revision 1.3  2000/12/25 09:47:39  neeri
#  Fix libraries for 68K build
#
#  Revision 1.2  2000/12/22 08:35:45  neeri
#  PPC, MrC, and SC builds work
#
#  Revision 1.1  2000/12/07 08:52:13  neeri
#  PPC app compiles and sort of runs
#
#  Revision 1.5  1998/04/21 22:27:03  neeri
#  MacPerl 5.2.0r4
#
#  Revision 1.4  1998/04/07 01:46:54  neeri
#  MacPerl 5.2.0r4b1
#
#  Revision 1.3  1997/11/18 00:54:05  neeri
#  MacPerl 5.1.5
#
#  Revision 1.2  1997/08/08 16:58:16  neeri
#  MacPerl 5.1.4b1
#
#  Revision 1.1  1997/06/23 17:11:14  neeri
#  Checked into CVS
#

# Bourque:Prog:Metrowerks:Metrowerks CodeWarrior:MSL:MSL_C++:MSL_Common:Include

OldMW68KLibraries	= "Bourque:Prog:Metrowerks:MPW:MPW:Libraries:OldMW68KLibraries:"
CWANSIInc	=	{{CWANSIIncludes}},"Bourque:Prog:Metrowerks:Metrowerks CodeWarrior:MSL:MSL_C++:MSL_Common:Include:"

PERL_SRC 	= ::perl:
MACPERL_SRC	= $(PERL_SRC)macos:

.INCLUDE : $(MACPERL_SRC)BuildRules.mk

DB			= ::db:
XL			= ::XL:
GD			= :perl:macos:ext:GD:libgd:
AEGizmos	= ::AEGizmos:
IC 			= ::IC:
SFIO		= "{{SFIO}}"
GUSI		= "{{GUSI}}"
MoreFiles	= ::MoreFiles:

COpt += -i $(MACPERL_SRC) -i $(PERL_SRC) -i ::db:include: -i ::IC: -i ::AEGizmos:include
ApplRez 		= 	Rez -a -t APPL -c McPL
ApplMWLOpt		=	${LOpt} -xm application -d
ApplLink68K		=	MWLink68K ${ApplMWLOpt} -model far
ApplLinkPPC		=	MWLinkPPC ${ApplMWLOpt} 
ApplMPWLOpt		=	${LOpt} -t APPL -w -mf 
ApplLinkSC		=	Link ${ApplMPWLOpt}  -model far
ApplLinkMrC		= 	PPCLink ${ApplMPWLOpt}
RsrcLink68K		= 	MWLink68K -xm coderesource

MacPerlSources	=		\
	MPUtils.c		\
	MPAEUtils.c		\
	MPAppleEvents.c		\
	MPGlobals.c		\
	MPEditions.c		\
	MPFile.c		\
	MPMain.c		\
	MPEditor.c		\
	MPWindow.c		\
	MPHelp.c		\
	MPScript.c		\
	MPSave.c		\
	MercutioAPI.c	\
	MPConsole.cp		\
	MPPreferences.c		\
	MPPseudoFile.cp		\
	MPAEVTStream.cp

.SOURCE : $(MACPERL_SRC)

PerlSources = runperl.c

Objects68K 		= {$(MacPerlSources) $(PerlSources)}.68K.o
ObjectsPPC 		= {$(MacPerlSources) $(PerlSources)}.PPC.o
ObjectsSC 		= {$(MacPerlSources) $(PerlSources)}.SC.o
ObjectsMrC 		= {$(MacPerlSources) $(PerlSources)}.MrC.o

Static_Ext_Mac	= 	\
	MacPerl:MacPerl 
Static_Ext_Std	= \
	re:re Fcntl:Fcntl File:Glob:Glob Sys:Hostname:Hostname \
	DynaLoader:DynaLoader NDBM_File:NDBM_File DB_File:DB_File Socket:Socket \
	Opcode:Opcode POSIX:POSIX IO:IO attrs:attrs Data:Dumper:Dumper \
	Devel:Peek:Peek
Static_Ext_Prefix		= 	$(MACPERL_SRC)ext:{$(Static_Ext_Mac)} $(PERL_SRC)ext:{$(Static_Ext_Std)}
Static_Ext_AutoInit_PPC	=	{$(Static_Ext_Prefix)}.Lib.PPC
Static_Ext_AutoInit_68K	=	{$(Static_Ext_Prefix)}.Lib.68K
Static_Ext_AutoInit_SC	=	{$(Static_Ext_Prefix)}.Lib.SC
Static_Ext_AutoInit_MrC	=	{$(Static_Ext_Prefix)}.Lib.MrC

PerlObj68K	=				\
	$(MACPERL_SRC)PLib:PerlLib.68K.Lib		\
	$(MACPERL_SRC)PLib:Perl.68K.Lib		\
	$(Static_Ext_AutoInit_68K)

PerlObjPPC	=				\
	$(MACPERL_SRC)PLib:PerlLib.PPC.Lib		\
	$(MACPERL_SRC)PLib:Perl.PPC.Lib		\
	$(Static_Ext_AutoInit_PPC)

PerlObjSC	=				\
	$(MACPERL_SRC)PLib:PerlLib.SC.Lib		\
	$(MACPERL_SRC)PLib:Perl.SC.Lib		\
	$(Static_Ext_AutoInit_SC)

PerlObjMrC	=				\
	$(MACPERL_SRC)PLib:PerlLib.MrC.Lib		\
	$(MACPERL_SRC)PLib:Perl.MrC.Lib		\
	$(Static_Ext_AutoInit_MrC)

MacPerlLibPPC	=					\
			"$(GUSI)lib:GUSI_Sfio.PPC.Lib"					\
			"$(GUSI)lib:GUSI_Core.PPC.Lib"					\
			"{{MWPPCLibraries}}MSL MPWCRuntime.Lib"			\
			"{{SharedLibraries}}InterfaceLib"				\
			$(SFIO)lib:sfio.PPC.Lib							\
			"{{MWPPCLibraries}}MSL C.PPC MPW(NL).Lib"		\
			"{{MWPPCLibraries}}MSL C++.PPC (NL).Lib"		\
			"{{SharedLibraries}}StdCLib"					\
			"{{SharedLibraries}}MathLib"					\
			"{{SharedLIbraries}}ThreadsLib"					\
			"{{SharedLibraries}}NavigationLib"				\
			"{{SharedLIbraries}}ObjectSupportLib"			\
			"{{SharedLibraries}}OpenTransportLib"			\
			"{{SharedLibraries}}OpenTptInternetLib"			\
			"{{PPCLibraries}}OpenTransportAppPPC.o"			\
			"{{PPCLibraries}}OpenTptInetPPC.o"				\
			"{{PPCLibraries}}PPCToolLibs.o"					\
			"$(IC)InternetConfigLib"						\
			"$(AEGizmos)AEGizmos4Perl.shlb.PPC"				\
			"$(DB)lib:db.Sfio.PPC.Lib"						\
			"$(XL)"XL.PPC.Lib								\
			"{{SharedLibraries}}AppleScriptLib"

MacPerlLibMrC	= 	\
			"$(GUSI)lib:GUSI_Sfio.MrC.Lib"					\
			"$(GUSI)lib:GUSI_Core.MrC.Lib"					\
			"$(SFIO)lib:sfio.MrC.Lib"						\
			"{{PPCLibraries}}MrCPlusLib.o"					\
			"{{PPCLibraries}}PPCStdCLib.o"					\
			"{{PPCLibraries}}StdCRuntime.o"					\
			"{{PPCLibraries}}PPCCRuntime.o"					\
			"{{SharedLibraries}}MathLib"					\
			"{{PPCLibraries}}PPCToolLibs.o"					\
			"{{SharedLibraries}}InterfaceLib"				\
			"{{SharedLibraries}}ThreadsLib"					\
			"{{SharedLibraries}}NavigationLib"				\
			"{{PPCLibraries}}MrCIOStreams.o"				\
			"{{SharedLibraries}}ObjectSupportLib"			\
			"{{SharedLibraries}}StdCLib"					\
			"{{SharedLibraries}}OpenTransportLib"			\
			"{{SharedLibraries}}OpenTptInternetLib"			\
			"{{PPCLibraries}}OpenTransportAppPPC.o"			\
			"{{PPCLibraries}}OpenTptInetPPC.o"				\
			"$(IC)InternetConfigLib"						\
			"$(AEGizmos)AEGizmos4Perl.shlb.PPC"				\
			"$(DB)lib:db.Sfio.MrC.Lib"						\
			"$(XL)"XL.MrC.Lib								\
			"{{SharedLibraries}}AppleScriptLib"

MacPerlLib68K	=											\
			"$(GUSI)lib:GUSI_Sfio.68K.Lib"					\
			"$(GUSI)lib:GUSI_Core.68K.Lib"					\
			"{{MW68KLibraries}}MSL MPWRuntime.68K.Lib"		\
			"{{MW68KLibraries}}MSL Runtime68K.Lib"			\
			"{{Libraries}}AEObjectSupportLib.o"				\
			"{{Libraries}}IntEnv.o"							\
			"{{Libraries}}ToolLibs.o"						\
			"{{MW68KLibraries}}MacOS.Lib"					\
			"{{MW68KLibraries}}MSL C.68K MPW(NL_4i_8d).Lib"	\
			"{{MW68KLibraries}}MSL C++.68K (4i_8d).Lib"		\
			"{{MW68KLibraries}}MathLib68K (4i_8d).Lib"		\
			$(SFIO)lib:sfio.68K.Lib							\
			"{{Libraries}}Navigation.far.o"					\
			"{{Libraries}}OpenTransportApp.o"				\
			"{{Libraries}}OpenTransport.o"					\
			"{{Libraries}}OpenTptInet.o"					\
			-s Libraries									\
			"$(AEGizmos)AEGizmos4Perl.Lib.68K"				\
			"$(DB)lib:db.Sfio.68K.Lib"						\
			"$(XL)"XL.68K.Lib								\
			"{{Libraries}}OSACompLib.o"						\
			"$(IC)ICGlueFar.o"		

MacPerlLibSC	=	\
			"$(GUSI)lib:GUSI_Sfio.SC.Lib"					\
			"$(GUSI)lib:GUSI_Core.SC.Lib"					\
			"$(SFIO)lib:sfio.SC.Lib"						\
			"{{CLibraries}}CPlusLib.far.o"					\
			"{{CLibraries}}StdCLib.far.o"					\
			"{{Libraries}}MacRuntime.o"						\
			"{{Libraries}}Interface.o"						\
			"{{Libraries}}IntEnv.far.o"						\
			"{{Libraries}}MathLib.far.o"					\
			"{{Libraries}}ToolLibs.far.o"					\
			"{{CLibraries}}IOStreams.far.o"					\
			"{{Libraries}}AEObjectSupportLib.o"				\
			"{{Libraries}}Navigation.far.o"					\
			"{{Libraries}}OpenTransport.o"					\
			"{{Libraries}}OpenTransportApp.o"				\
			"{{Libraries}}OpenTptInet.o"					\
			"$(AEGizmos)AEGizmos4Perl.Lib.SC"				\
			"$(DB)lib:db.Sfio.SC.Lib"						\
			"$(IC)ICGlueFar.o"								\
			"$(XL)"XL.SC.Lib

all	: MacPerl "MacPerl Help" MacPerlTest.Script MPDroplet

clean	:	
	Delete :Obj:Å

realclean	:	clean
	Delete -i MacPerl MacPerl.PPC MacPerl.68K MacPerl.SC MacPerl.MrC

MacPerl.PPC : $(ObjectsPPC) $(PerlObjPPC)
	$(ApplLinkPPC) -name Perl -o MacPerl.PPC :Obj:{$(ObjectsPPC)} $(PerlObjPPC) $(MacPerlLibPPC)
	MergeFragment "$(AEGizmos)AEGizmos4Perl.shlb.PPC" MacPerl.PPC
MacPerl.PPC	::	MacPerl.r MacPerl.rsrc MPTerminology.r MPBalloons.r :Obj:FontLDEF.rsrc
	$(ApplRez) MacPerl.r -d APPNAME=¶"Perl¶" -o MacPerl.PPC
	SetFile -a B MacPerl.PPC

MacPerl.MrC : $(ObjectsMrC) $(PerlObjMrC)
	$(ApplLinkMrC) -fragname Perl -o MacPerl.MrC :Obj:{$(ObjectsMrC)} $(PerlObjMrC) $(MacPerlLibMrC)
	MergeFragment "$(AEGizmos)AEGizmos4Perl.shlb.PPC" MacPerl.MrC
MacPerl.MrC	::	MacPerl.r MacPerl.rsrc MPTerminology.r MPBalloons.r :Obj:FontLDEF.rsrc
	$(ApplRez) MacPerl.r -d APPNAME=¶"Perl¶" -o MacPerl.MrC
	SetFile -a B MacPerl.MrC

MacPerl.68K : $(Objects68K) $(PerlObj68K)
	$(ApplLink68K) -o MacPerl.68K :Obj:{$(Objects68K)} $(PerlObj68K) $(MacPerlLib68K)
MacPerl.68K	::	MacPerl.r MacPerl.rsrc MPTerminology.r MPBalloons.r :Obj:FontLDEF.rsrc
	$(ApplRez) MacPerl.r -o MacPerl.68K
	SetFile -a B MacPerl.68K

MacPerl.SC : $(ObjectsSC) $(PerlObjSC)
	$(ApplLinkSC) -o MacPerl.SC :Obj:{$(ObjectsSC)} $(PerlObjSC) $(MacPerlLibSC)
MacPerl.SC	::	MacPerl.r MacPerl.rsrc MPTerminology.r MPBalloons.r :Obj:FontLDEF.rsrc
	$(ApplRez) MacPerl.r -d APPNAME=¶"Perl¶" -o MacPerl.SC
	SetFile -a B MacPerl.SC

macperl.exp: ::perl:perl.stubsymbols
	perl -ne 'print unless /^#|^__/' ::perl:perl.stubsymbols>macperl.exp
	echo __nw__FUl >>macperl.exp
	echo __dl__FPv >>macperl.exp

MacPerl : MacPerl.PPC MacPerl.68K
	Duplicate -y MacPerl.PPC MacPerl
	Echo 'Include "MacPerl.68K" '¶''CODE'¶'';'	¶
		  'Include "MacPerl.68K" '¶''DATA'¶'';'	¶
		| Rez -a -c McPL -t APPL -o MacPerl
	$(MACPERL_SRC)UnPreload MacPerl

":Obj:FontLDEF.rsrc" : MPFontLDEF.c.68K.o
	$(RsrcLink68K) -t rsrc -c RSED -rt LDEF=128 -o :Obj:FontLDEF.rsrc 	¶
		:Obj:MPFontLDEF.c.68K.o "{{MW68KLibraries}}"MacOS.lib

MPTerminology.r	:	MPTerminology.aete
	:macscripts:Aete2Rez MPTerminology.aete > MPTerminology.r

MPBalloons.r	:	MPBalloons.ball
	:macscripts:Balloon2Rez MPBalloons.ball

MPGlobals.c.PPC.o	:	MPGlobals.h
MPGlobals.c.68K.o	:	MPGlobals.h

"HTML Help" 		:	MacPerl.help
#	BuildHelpIndex	"HTML Help" MacPerl.help
#	BuildLibraryIndex "MacPerl Help" :lib:
"MacPerl Help" 		:	MacPerl.podhelp
#	BuildHelpIndex	"MacPerl Help" MacPerl.podhelp
#	BuildLibraryIndex "MacPerl Help" :lib:

MacPerlTest.Script	:	MakeMacPerlTest
	MakeMacPerlTest ¶
		::perl:t:Å:Å.t> MacPerlTest.Script

MPDroplet.code : MPDrop.c.68K.o
	$(ApplLink68K) -t 'rsrc' -c 'RSED' -sym on		¶
		:Obj:MPDrop.c.68K.o					¶
		"$(OldMW68KLibraries)ANSIFa(N/4i/8d)C.68K.Lib"	¶
		"{{MW68KLibraries}}MathLib68K Fa(4i_8d).Lib"	¶
		"{{MW68KLibraries}}MacOS.Lib" -o MPDroplet.code	

MPDroplet : ":MacPerl Extensions:Droplet"	

":MacPerl Extensions:Droplet" : MPDroplet.code MPDroplet.r MPExtension.r MacPerl.rsrc
	Rez -t McPp -c McPL -o ":MacPerl Extensions:Droplet" MPDroplet.r
		
Distr : all
	Distribute MacPerl.distr Mac_Perl_510r2_appl.sit

.INCLUDE : $(MACPERL_SRC)BulkBuildRules.mk
