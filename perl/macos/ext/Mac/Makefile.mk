PERL_SRC	=	:::

.INCLUDE : :::BuildRules.mk

COpt += -i :::

dirs = 	\
	AppleEvents:AppleEvents			\
	Components:Components			\
	Controls:Controls				\
	Dialogs:Dialogs					\
	Events:Events					\
	Files:Files						\
	Fonts:Fonts						\
	Gestalt:Gestalt					\
	InternetConfig:InternetConfig	\
	Lists:Lists						\
	Memory:Memory					\
	Menus:Menus						\
	MoreFiles:MoreFiles				\
	Movies:Movies					\
	OSA:OSA							\
	Processes:Processes				\
	QDOffscreen:QDOffscreen			\
	QuickDraw:QuickDraw				\
	QuickTimeVR:QuickTimeVR			\
	Resources:Resources				\
	Sound:Sound						\
	Speech:Speech					\
	SpeechRecognition:SpeechRecognition	\
	StandardFile:StandardFile		\
	TextEdit:TextEdit				\
	Types:Types						\
	Windows:Windows

all static dynamic install install_static install_dynamic: Obj Mac.c.o.68K Mac.c.o.680 Mac.c.o.PPC
	For dir in $(dirs:f)
		Directory {{dir}}
		Set Echo 0
		If `Newer Makefile.PL Makefile.mk` == "Makefile.PL"
			::::miniperl Makefile.PL
		End
		BuildProgram $@
		directory ::
		Set Echo 1
	End
	$(Lib68K) -o Mac.Lib.68K :Obj:Mac.c.o.68K :{$(dirs)}.Lib.68K
	$(Lib68K) -o Mac.Lib.680 :Obj:Mac.c.o.680 :{$(dirs)}.Lib.680
	$(LibPPC) -o Mac.Lib.PPC :Obj:Mac.c.o.PPC :{$(dirs)}.Lib.PPC

Mac.c : Makefile.mk
	perl WriteMacInit $(dirs:f) > Mac.c

.INCLUDE : :::BulkBuildRules.mk
