.POSIX:
PREFIX = /usr/local

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

INCS = -I$(X11INC) -I/usr/include/freetype2
LIBS = -L$(X11LIB) -lX11 -lfontconfig -lXft

CPPFLAGS = -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
CFLAGS   = -std=c99 -pedantic -Wall -Os $(INCS) $(CPPFLAGS)
LDFLAGS  = $(LIBS)

CC = gcc

SRC = drw.c dmenu.c util.c
OBJ = $(SRC:.c=.o)

all: dmenu

.c.o:
	$(CC) -c $(CFLAGS) $<

$(OBJ): drw.h

dmenu: dmenu.o drw.o util.o
	$(CC) -o $@ dmenu.o drw.o util.o $(LDFLAGS)

clean:
	rm -f dmenu $(OBJ)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dmenu dmenu_run $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_run

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu\
		$(DESTDIR)$(PREFIX)/bin/dmenu_run\
