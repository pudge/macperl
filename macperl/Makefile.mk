#######################################################################
# Project	: MacPerl		-
# File		: Makefile.mk	-	dmake Makefile for MacPerl
# Author	: Matthias Neeracher
# Language	: MPW Shell/Make
#
#  $Log$
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

COpt += -i $(MACPERL_SRC) -i $(PERL_SRC) -i ::db:include: -i ::IC: -i ::AEGizmos:include -d MALLOC_LOG -w nopossible
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

Static_Ext_Mac	= 	\
	MacPerl:MacPerl 
Static_Ext_Std	= \
	DynaLoader:DynaLoader NDBM_File:NDBM_File DB_File:DB_File Socket:Socket \
	Opcode:Opcode POSIX:POSIX IO:IO
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

MacPerlLibPPC	=					\
			"$(GUSI)lib:GUSI_MPW.PPC.Lib"					\
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
			"$(AEGizmos)AEGizmos4Perl.Lib.PPC"				\
			"$(DB)lib:db.Sfio.PPC.Lib"						\
			"$(XL)"XL.PPC.Lib								\
			"{{SharedLibraries}}AppleScriptLib"

MacPerlLib68K	=					\
	"$(GUSI)Lib:GUSIDispatch.Lib.68K"	\
	$(SFIO)lib:sfio.Lib.68K	\
	"$(OldMW68KLibraries)ANSIFa(N/4i/8d)C.68K.Lib"	\
	"$(AEGizmos)AEGizmos4Perl.Lib.68K"		\
	"{{MW68KLibraries}}MathLib68K Fa(4i_8d).Lib"	\
	"$(GUSI)Lib:SfioGUSI.Lib.68K"		\
	"{{MW68KLibraries}}MacOS.Lib"			\
	"$(IC)ICGlueFar.o"			\
	"{{MW68KLibraries}}AEObjectSupportLib.o"	\
	"$(OldMW68KLibraries)CPlusPlus.lib"		\
	"$(OldMW68KLibraries)MPWRuntime.68K.Lib"		\
	"$(GUSI)Lib:CursorCtl.Lib.68K"	\
	"{{MW68KLibraries}}QTVR.MW.c.o"	\
	"{{MW68KLibraries}}ToolLibs.o"			\
	"{{MW68KLibraries}}PLStringFuncs.glue.lib"	\
	"$(DB)Sfiodb.Lib.68K"			\
	"$(XL)XL.Lib.68K"			\
	"{{MW68KLibraries}}OSACompLib.o"

all	: MacPerl "MacPerl Help" MacPerlTest.Script MPDroplet

clean	:	
	Delete :Obj:Å

realclean	:	clean
	Delete -i MacPerl MacPerl.PPC MacPerl.68K

MacPerl.PPC : $(ObjectsPPC) $(PerlObjPPC)
	$(ApplLinkPPC) -name Perl -o MacPerl.PPC :Obj:{$(ObjectsPPC)} $(PerlObjPPC) $(MacPerlLibPPC)
MacPerl.PPC	::	MacPerl.r MacPerl.rsrc MPTerminology.r MPBalloons.r :Obj:FontLDEF.rsrc
	$(ApplRez) MacPerl.r -d APPNAME=¶"Perl¶" -o MacPerl.PPC
	SetFile -a B MacPerl.PPC

MacPerl.68K : $(Objects68K) $(PerlObj68K)
	$(ApplLink68K) -o MacPerl.68K :Obj:{$(Objects68K)} -sb PerlCore $(PerlObj68K) $(MacPerlLib68K)
MacPerl.68K	::	MacPerl.r MacPerl.rsrc MPTerminology.r MPBalloons.r :Obj:FontLDEF.rsrc
	$(ApplRez) MacPerl.r -o MacPerl.68K
	SetFile -a B MacPerl.68K

macperl.exp: ::perl:perl.stubsymbols
	perl -ne 'print unless /^#|^__/' ::perl:perl.stubsymbols>macperl.exp
	echo __nw__FUl >>macperl.exp
	echo __dl__FPv >>macperl.exp

MacPerl : MacPerl.PPC MacPerl.68K
	Duplicate -y MacPerl.PPC MacPerl
	Echo 'Include "MacPerl.68K" '¶''CODE'¶'';'	¶
		  'Include "MacPerl.68K" '¶''DATA'¶'';'	¶
		| Rez -a -c McPL -t APPL -o MacPerl
	$(PERL_SRC)UnPreload MacPerl

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
	BuildHelpIndex	"HTML Help" MacPerl.help
	BuildLibraryIndex "MacPerl Help" :lib:
"MacPerl Help" 		:	MacPerl.podhelp
	BuildHelpIndex	"MacPerl Help" MacPerl.podhelp
	BuildLibraryIndex "MacPerl Help" :lib:

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
