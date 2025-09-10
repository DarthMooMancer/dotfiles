PREFIX = /usr/local

CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L
CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os -I/usr/X11R6/include -I/usr/include/freetype2 ${CPPFLAGS}
LDFLAGS  = -L/usr/X11R6/lib -lX11 -lfontconfig -lXft

SRC = bar.c drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h 

dwm: ${OBJ}
	gcc -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ}

install: dwm
	install -Dm755 dwm ${DESTDIR}${PREFIX}/bin/dwm

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
