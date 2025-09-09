#include "bar.h"
#include <stdio.h>

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
    snprintf(out, len, "V: %s  A: %s", vol(), age());
}
