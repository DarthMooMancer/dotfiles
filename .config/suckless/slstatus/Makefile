.POSIX:

PREFIX  = /usr/local
CC      = gcc
CFLAGS  = -std=c17 -pedantic -Wall -Wextra -Wno-unused-parameter -O2 -march=native \
           $(shell pkg-config --cflags x11) -D_DEFAULT_SOURCE
LDFLAGS = -s $(shell pkg-config --libs-only-L x11)
LDLIBS  = $(shell pkg-config --libs-only-l x11)

all: slstatus

slstatus: slstatus.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

clean:
	rm -f slstatus

install: all
	install -Dm755 slstatus "$(DESTDIR)$(PREFIX)/bin/slstatus"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/slstatus"
