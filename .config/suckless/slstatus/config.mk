VERSION = 1.0
PREFIX = /usr/local

CPPFLAGS = $(shell pkg-config --cflags x11) -D_DEFAULT_SOURCE -DVERSION=\"${VERSION}\"
LDFLAGS  = $(shell pkg-config --libs-only-L x11) -s
LDLIBS   = $(shell pkg-config --libs-only-l x11)
CFLAGS = -std=c17 -pedantic -Wall -Wextra -Wno-unused-parameter -O2 -march=native

CC = gcc
