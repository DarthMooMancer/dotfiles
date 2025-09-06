VERSION = 5.4

PREFIX = /usr/local

CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\"
CFLAGS   = -std=c99 -pedantic -Wall -Os -I/usr/X11R6/include -I/usr/include/freetype2 $(CPPFLAGS)
LDFLAGS  = -L/usr/X11R6/lib -lX11 -lfontconfig -lXft

CC = gcc
