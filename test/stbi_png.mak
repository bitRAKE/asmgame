# NMAKE makefile
# see https://learn.microsoft.com/en-us/cpp/build/reference/nmake-reference

fasm2=..\fasm2.cmd
STB=..\ext\stb
LIBS=..\library

.SUFFIXES : .asm.obj

.asm.obj :
	$(fasm2) -e 5 $<
	@if not exist $(<:.asm=.obj) exit 1


all : stbi_png.exe tidy


stbi_png.exe : stbi_png.obj $(LIBS)\stb_image.lib
	link @$*.response $**

stbi_png.response : stbi_png.obj


$(LIBS)\stb_image.lib : $(LIBS)\stb_image.c $(STB)\stb_image.h
	set CL=/O2 /EHs-c- /GL /GS- /sdl- /MT /Zc:inline /favor:AMD64 /arch:AVX2 /nologo
	cl /TC /c /Fo:stb_image.obj $(LIBS)\stb_image.c
	lib /nologo /LTCG /OUT:$(LIBS)\stb_image.lib stb_image.obj



.SILENT :

tidy :
	del /S /Q *.obj *.response >NUL 2>&1

clean : tidy
	del /S /Q *.exp *.lib *.dll *.exe *.zip >NUL 2>&1

#package : clean
#	tar -a -cf main.zip --exclude=main.zip *
