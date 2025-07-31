include config.mk

SRC = drw.c dmenu.c util.c
OBJ = $(SRC:.c=.o)

all: dmenu

.c.o:
	$(CC) -c $(CFLAGS) $<

$(OBJ): arg.h config.h config.mk drw.h

dmenu: dmenu.o drw.o util.o
	$(CC) -o $@ dmenu.o drw.o util.o $(LDFLAGS)

clean:
	rm -f dmenu stest $(OBJ)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dmenu dmenu_path dmenu_run $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_run

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu\
		$(DESTDIR)$(PREFIX)/bin/dmenu_path\
		$(DESTDIR)$(PREFIX)/bin/dmenu_run\

.PHONY: all clean install uninstall
