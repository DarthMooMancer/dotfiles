.POSIX:

include config.mk

# Objects we actually need
OBJ = slstatus.o

all: slstatus

slstatus.o: slstatus.c
	$(CC) -o $@ -c $(CPPFLAGS) $(CFLAGS) slstatus.c

slstatus: $(OBJ)
	$(CC) -o $@ $(LDFLAGS) $(OBJ) $(LDLIBS)

clean:
	rm -f slstatus $(OBJ)

install: all
	mkdir -p "$(DESTDIR)$(PREFIX)/bin"
	cp -f slstatus "$(DESTDIR)$(PREFIX)/bin"
	chmod 755 "$(DESTDIR)$(PREFIX)/bin/slstatus"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/slstatus"
