ifeq ($(OS),Windows_NT)
	CC="C:/Program Files (x86)/Dev-Cpp/MinGW32/bin/gcc.exe"
	GCC="C:/Program Files (x86)/Dev-Cpp/MinGW32/bin/g++.exe"
	SHIT="\\"# just for clean
	DEL=DEL /F /S /Q
	EXT=.exe
	INCS=
	LIBS=
	CFLAGS=-finput-charset=GBK
	LFLAGS=-lfltk -lfltk_forms -lfltk_gl -lfltk_images -lfltk_jpeg -lfltk_png -lfltk_z  -lfltk -lole32 -luuid -lcomctl32 -lwsock32 -lgdi32 -luser32 -lkernel32 -mwindows
else
	CC=gcc
	GCC=g++
	SHIT=/
	DEL=rm -f
	EXT=
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		INCS=-I./inc
		LIBS=-L"/usr/local/Cellar/freeimage/3.15.4/lib"
	endif
	ifeq ($(UNAME_S),Darwin)
		INCS=-I./inc
		LIBS=-L"/usr/local/Cellar/freeimage/3.15.4/lib"
	endif
	CFLAGS=`fltk-config --cflags`
	LFLAGS=`fltk-config --libs --use-images --ldflags`
endif

CFLAGS+=-O2 -Wall -fpermissive
LFLAGS+=-lm

OBJSDIR=obj
OUTDIR=.

OBJS=$(OBJSDIR)/main.o

TARGET=$(OUTDIR)$(SHIT)main$(EXT)


all:DEFS=-DIS_ALL=1
all:$(OBJS)
	$(GCC) $(CFLAGS) $^ $(LIBS) $(LFLAGS) -o $(TARGET)

$(OBJSDIR)/%.o:%.c
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c $< -o $@

$(OBJSDIR)/%.o:%.cpp
	$(GCC) $(CFLAGS) $(DEFS) $(INCS) -c $< -o $@

check-syntax:
	$(CXXCOMPILE) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)

clean:
	$(DEL) $(OBJSDIR)$(SHIT)*.o
	$(DEL) $(OBJSDIR)$(SHIT)*.~
	$(DEL) $(OUTDIR)$(SHIT)$(TARGET)

rebuild:clean all
