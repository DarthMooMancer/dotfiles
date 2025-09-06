.POSIX:

PREFIX = /usr/local

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

# includes and libs
INCS = $(shell pkg-config --cflags x11 fontconfig freetype2 harfbuzz) # -I$(X11INC)
LIBS = -L$(X11LIB) -lm -lrt -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2` \
       `$(PKG_CONFIG) --libs harfbuzz`

# flags
STCPPFLAGS = -D_XOPEN_SOURCE=600
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

# compiler and linker
CC = gcc

SRC = st.c x.c hb.c
OBJ = $(SRC:.c=.o)

all: st

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h
hb.o: st.h

$(OBJ): config.h

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ)

install: st
	install -Dm755 st $(DESTDIR)$(PREFIX)/bin/st

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st
