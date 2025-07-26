#include "/home/andrew/.config/suckless/dwm/themes/everforest.h"
static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static const char *fonts[] = {
	"CaskaydiaCove NFM style:Regular:size=12"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	[SchemeNorm] = { foreground, background },
	[SchemeSel] = { background, yellow },
	[SchemeOut] = { red, background },
};

static unsigned int lines      = 0;
static unsigned int columns    = 0;
static const char worddelimiters[] = " ";
