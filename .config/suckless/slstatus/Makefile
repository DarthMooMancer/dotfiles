.POSIX:

PREFIX  = /usr/local
CFLAGS  = -std=c17 -pedantic -Wall -Wextra -Wno-unused-parameter -O2 -march=native $(shell pkg-config --cflags x11) -D_DEFAULT_SOURCE

slstatus: slstatus.c
	gcc $(CFLAGS) -o $@ $< -s $(shell pkg-config --libs-only-L x11) $(shell pkg-config --libs-only-l x11)

clean:
	rm -f slstatus

install: slstatus
	install -Dm755 slstatus "$(DESTDIR)$(PREFIX)/bin/slstatus"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/slstatus"
