INSTALL=/usr/local
CC=gcc
CFLAGS=-I. -O2 -fPIC

OS := $(shell uname)
ifeq ($(OS),Darwin)
	LIBNAME=libredblack.dylib
else
	LIBNAME=libredblack.so
endif

all: libredblack.a $(LIBNAME)

libredblack.a: redblack.o
	ar -r libredblack.a redblack.o

libredblack.dylib:
	$(CC) -o libredblack.dylib redblack.o -dynamiclib

libredblack.so:
	$(CC) -shared -Wl,-soname,libredblack.so  -o libredblack.so redblack.o

install: libredblack.a
	cp redblack.h $(INSTALL)/include
	cp libredblack.a $(INSTALL)/lib
	cp $(LIBNAME) $(INSTALL)/lib

clean:
	rm -f *.o libredblack.a $(LIBNAME)
