#define _GNU_SOURCE
#include <fcntl.h>        // for AT_FDCWD
#include <sys/syscall.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <X11/Xlib.h>
#include <stdarg.h>
#include <sys/stat.h>

static volatile sig_atomic_t done;
struct arg {
	const char *(*func)(const char *);
	const char *fmt;
	const char *args;
};

void die(const char *fmt, ...) {
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(1);
}

static void terminate() {
	done = 1;
}

const char* bgt(const char *_) {
	(void)_;
	static char buf[5];
	time_t now = time(NULL), last = now;
	FILE *f = fopen("/tmp/last_wallpaper_time", "r");
	if (!f || fscanf(f, "%ld", &last) != 1) last = now;
	if (f) fclose(f);
	int rem = 600 - (int)(now - last);
	if (rem < 0) rem = 0;
	if (snprintf(buf, sizeof(buf), "%d:%02d", (rem / 60), (rem % 60)) < 0) return NULL;
	return buf;
}

const char* vol(const char *_) {
	(void)_;
	static char buf[5];
	float v;
	FILE *fp = popen("wpctl get-volume @DEFAULT_AUDIO_SINK@", "r");
	if (!fp || fscanf(fp, "Volume: %f", &v) != 1) return NULL;
	pclose(fp);
	snprintf(buf, sizeof(buf), "%d%%", (int)(v * 100));
	return buf;
}

const char* age(const char *_) {
	(void)_;
	static char buf[4];
	static time_t last;
	time_t now = time(NULL);
	if (now - last < 900) return buf;
	time_t created;
	struct statx stx;
	created = (!syscall(SYS_statx, AT_FDCWD, "/", 0, STATX_BTIME, &stx) && (stx.stx_mask & STATX_BTIME)) ? stx.stx_btime.tv_sec : now;
	snprintf(buf, sizeof(buf), "%d", (int)((now - created) / 86400));
	last = now;
	return buf;
}

int main(int argc, char *argv[]) {
	static Display *dpy;
	struct sigaction act;
	size_t i, len;
	int ret;
	char status[36];
	static const struct arg args[] = {
		{ bgt, 	"W: %s · ",  NULL },	
		{ vol, 	"V: %s · ",  NULL },
		{ age,	"A: %sd",    NULL },
	};

	memset(&act, 0, sizeof(act));
	act.sa_handler = terminate;
	sigaction(SIGINT,  &act, NULL);
	sigaction(SIGTERM, &act, NULL);
	act.sa_flags |= SA_RESTART;

	if (!(dpy = XOpenDisplay(NULL))) die("XOpenDisplay: Failed to open display");
	do {
		status[0] = '\0';
		for (i = len = 0; i < (sizeof(args) / sizeof(args[0])); i++) {
			const char *res = args[i].func(args[i].args);
			if (!res) res = "n/a";
			if ((ret = snprintf(status + len, sizeof(status) - len, args[i].fmt, res)) < 0) break;
			len += ret;
		}

		if (XStoreName(dpy, DefaultRootWindow(dpy), status) < 0) die("XStoreName: Allocation failed");
		XFlush(dpy);

		if (!done) {
			struct timespec ts = { .tv_sec = 0, .tv_nsec = 100 * 1000000 }; // 100ms
			nanosleep(&ts, NULL);
		}
	} while (!done);
	XStoreName(dpy, DefaultRootWindow(dpy), NULL);
	if (XCloseDisplay(dpy) < 0) die("XCloseDisplay: Failed to close display");
	return 0;
}
