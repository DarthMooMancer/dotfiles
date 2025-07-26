.POSIX:

include config.mk

REQ = util
COM = components/run_command

all: slstatus

$(COM:=.o): config.mk $(REQ:=.h) slstatus.h
slstatus.o: slstatus.c slstatus.h arg.h config.h config.mk $(REQ:=.h)

.c.o:
	$(CC) -o $@ -c $(CPPFLAGS) $(CFLAGS) $<

config.h:
	cp config.def.h $@

slstatus: slstatus.o $(COM:=.o) $(REQ:=.o)
	$(CC) -o $@ $(LDFLAGS) $(COM:=.o) $(REQ:=.o) slstatus.o $(LDLIBS)

clean:
	rm -f slstatus slstatus.o $(COM:=.o) $(REQ:=.o) slstatus-${VERSION}.tar.gz

dist:
	rm -rf "slstatus-$(VERSION)"
	mkdir -p "slstatus-$(VERSION)/components"
	cp -R LICENSE Makefile README config.mk config.def.h \
	      arg.h slstatus.h slstatus.c $(REQ:=.c) $(REQ:=.h) \
	      slstatus.1 "slstatus-$(VERSION)"
	cp -R $(COM:=.c) "slstatus-$(VERSION)/components"
	tar -cf - "slstatus-$(VERSION)" | gzip -c > "slstatus-$(VERSION).tar.gz"
	rm -rf "slstatus-$(VERSION)"

install: all
	mkdir -p "$(DESTDIR)$(PREFIX)/bin"
	cp -f slstatus "$(DESTDIR)$(PREFIX)/bin"
	chmod 755 "$(DESTDIR)$(PREFIX)/bin/slstatus"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/slstatus"
