#define _GNU_SOURCE
#define AT_FDCWD -100
#include <sys/syscall.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/stat.h>
#include <X11/Xlib.h>

void die(const char *msg) {
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

const char* bgt() {
	static char buf[5];
	time_t now = time(NULL), last = now;
	FILE *f = fopen("/tmp/last_wallpaper_time", "r");
	if(fscanf(f, "%ld", &last) != 1) last = now;
	fclose(f);
	int rem = 600 - (int)(now - last);
	if (rem < 0) rem = 0;
	if (snprintf(buf, sizeof(buf), "%d:%02d", (rem / 60), (rem % 60)) < 0) return NULL;
	return buf;
}

const char* vol() {
	static char buf[5];
	float v;
	FILE *fp = popen("wpctl get-volume @DEFAULT_AUDIO_SINK@", "r");
	if (!fp || fscanf(fp, "Volume: %f", &v) != 1) return NULL;
	pclose(fp);
	snprintf(buf, sizeof(buf), "%d%%", (int)(v * 100));
	return buf;
}

const char* age() {
	static char buf[4];
	static time_t last;
	time_t now = time(NULL);
	if (now - last < 900) return buf;
	struct statx stx;
	time_t created = (!syscall(SYS_statx, AT_FDCWD, "/", 0, STATX_BTIME, &stx) && (stx.stx_mask & STATX_BTIME)) ? stx.stx_btime.tv_sec : now;
	snprintf(buf, sizeof(buf), "%d", (int)((now - created) / 86400));
	last = now;
	return buf;
}

volatile sig_atomic_t done = 0;
void terminate() { done = 1; }

int main() {
	Display *dpy;
	struct sigaction act = { .sa_handler = terminate, .sa_flags = SA_RESTART };
	struct arg {
		const char *(*func)(void);
		const char *fmt;
	};
	const struct arg args[] = {
		{ bgt, 	"W: %s " }, // 9 bytes
		{ vol, 	"V: %s " }, // 9 bytes
		{ age,	"A: %sd" }, // 8 bytes
	};
	size_t i, len;
	int ret;
	char status[32];
	const char *res;

	sigaction(SIGINT,  &act, NULL);
	sigaction(SIGTERM, &act, NULL);

	if (!(dpy = XOpenDisplay(NULL))) die("XOpenDisplay: Failed to open display");
	while(!done) {
		status[0] = '\0';
		for (i = len = 0; i < 3; i++) {
			res = args[i].func();
			if (!res) res = "n/a";
			if ((ret = snprintf(status + len, sizeof(status) - len, args[i].fmt, res)) < 0) break;
			len += ret;
		}

		if (XStoreName(dpy, DefaultRootWindow(dpy), status) < 0) die("XStoreName: Allocation failed");
		XFlush(dpy);
		nanosleep(&(struct timespec){ .tv_sec = 0, .tv_nsec = 500 * 1000000 }, NULL); // 500ms 
	}
	XStoreName(dpy, DefaultRootWindow(dpy), NULL);
	if (XCloseDisplay(dpy) < 0) die("XCloseDisplay: Failed to close display");
	return 0;
}
