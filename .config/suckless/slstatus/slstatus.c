#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <X11/Xlib.h>
#include <stdarg.h>
#include <stdint.h>
#define LEN(x) (sizeof(x) / sizeof((x)[0]))
#define MAXLEN 2048

char buf[1024];
static volatile sig_atomic_t done;
static Display *dpy;
const unsigned short interval = 1000;
const char unknown_str[] = "n/a";

void
die(const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);

	if (fmt[0] && fmt[strlen(fmt) - 1] == ':') {
		fputc(' ', stderr);
		perror(NULL);
	} else {
		fputc('\n', stderr);
	}
	va_end(ap);
	exit(1);
}

int
esnprintf(char *str, size_t size, const char *fmt, ...)
{
	va_list ap;
	int ret;

	va_start(ap, fmt);
	ret = vsnprintf(str, size, fmt, ap);

	if (ret < 0) {
		return -1;
	} else if ((size_t)ret >= size) {
		return -1;
	}
	va_end(ap);

	return ret;
}

struct arg {
	const char *(*func)(const char *);
	const char *fmt;
	const char *args;
};

static void
terminate(const int signo)
{
	if (signo != SIGUSR1)
		done = 1;
}

static void
difftimespec(struct timespec *res, struct timespec *a, struct timespec *b)
{
	res->tv_sec = a->tv_sec - b->tv_sec - (a->tv_nsec < b->tv_nsec);
	res->tv_nsec = a->tv_nsec - b->tv_nsec +
	               (a->tv_nsec < b->tv_nsec) * 1E9;
}

const char *
run_command(const char *cmd)
{
	char *p;
	FILE *fp;

	if (!(fp = popen(cmd, "r"))) {
		return NULL;
	}

	p = fgets(buf, sizeof(buf) - 1, fp);
	if (pclose(fp) < 0) {
		return NULL;
	}
	if (!p)
		return NULL;

	if ((p = strrchr(buf, '\n')))
		p[0] = '\0';

	return buf[0] ? buf : NULL;
}

static const
struct arg args[] = {
	{ run_command, 	" %s till swap  •  ", 	"sh /home/andrew/.config/suckless/slstatus/wallpaper-countdown.sh" },
	{ run_command, 	"VOL at %s  •  ", 	"wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d%%\", $2 * 100}'" },
	{ run_command,	"%s / 731 installed ", 	"sh -c 'echo $(( ( $(date +%s) - $(stat -c %W /) ) / 86400 ))'" },
};

int
main(int argc, char *argv[])
{
	struct sigaction act;
	struct timespec start, current, diff, intspec, wait;
	size_t i, len;
	int ret;
	char status[MAXLEN];
	const char *res;

	memset(&act, 0, sizeof(act));
	act.sa_handler = terminate;
	sigaction(SIGINT,  &act, NULL);
	sigaction(SIGTERM, &act, NULL);
	act.sa_flags |= SA_RESTART;
	sigaction(SIGUSR1, &act, NULL);

	if (!(dpy = XOpenDisplay(NULL)))
		die("XOpenDisplay: Failed to open display");

	do {
		if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
			die("clock_gettime:");

		status[0] = '\0';
		for (i = len = 0; i < LEN(args); i++) {
			if (!(res = args[i].func(args[i].args)))
				res = unknown_str;

			if ((ret = esnprintf(status + len, sizeof(status) - len,
			                     args[i].fmt, res)) < 0)
				break;

			len += ret;
		}

		if (XStoreName(dpy, DefaultRootWindow(dpy), status) < 0)
			die("XStoreName: Allocation failed");
		XFlush(dpy);

		if (!done) {
			if (clock_gettime(CLOCK_MONOTONIC, &current) < 0)
				die("clock_gettime:");
			difftimespec(&diff, &current, &start);

			intspec.tv_sec = interval / 1000;
			intspec.tv_nsec = (interval % 1000) * 1E6;
			difftimespec(&wait, &intspec, &diff);

			if (wait.tv_sec >= 0 &&
			    nanosleep(&wait, NULL) < 0 &&
			    errno != EINTR)
					die("nanosleep:");
		}
	} while (!done);

	XStoreName(dpy, DefaultRootWindow(dpy), NULL);
	if (XCloseDisplay(dpy) < 0)
		die("XCloseDisplay: Failed to close display");

	return 0;
}
