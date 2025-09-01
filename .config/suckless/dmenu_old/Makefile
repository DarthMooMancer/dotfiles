.POSIX:

PREFIX = /usr/local
CFLAGS   = -std=c17 -pedantic -Wall -Wextra -Wno-unused-parameter -Os -march=native $(shell pkg-config --cflags x11 xft fontconfig) -D_DEFAULT_SOURCE

dmenu: dmenu.c 
	gcc $(CFLAGS) -o $@ $< -L/usr/X11R6/lib -lX11 -lfontconfig -lXft

clean:
	rm -f dmenu 

install: dmenu 
	install -Dm755 dmenu "$(DESTDIR)$(PREFIX)/bin/dmenu"
	install -Dm755 dmenu_run "$(DESTDIR)$(PREFIX)/bin/dmenu_run"

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu $(DESTDIR)$(PREFIX)/bin/dmenu_run
