#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"

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
	static char buf[5];
	int days;
	FILE *fp = popen("sh -c 'echo $(( ( $(date +%s) - $(stat -c %W /) ) / 86400 ))'", "r");
	if (!fp || fscanf(fp, "%d", &days) != 1) return NULL;
	pclose(fp);
	snprintf(buf, sizeof(buf), "%dd", days);
	return buf;
}

void execute_bar(char *out, size_t len) {
    snprintf(out, len, " V: %s A: %s ", vol(), age());
}

void die(const char *fmt, ...) {
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);

	if (fmt[0] && fmt[strlen(fmt)-1] == ':') {
		fputc(' ', stderr);
		perror(NULL);
	} else fputc('\n', stderr);

	exit(1);
}

void * ecalloc(size_t nmemb, size_t size) {
	void *p;
	if (!(p = calloc(nmemb, size))) die("calloc:");
	return p;
}
