/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *fonts[] = {
	"CaskaydiaCove NFM style:SemiBold:size=11"
};
static const char *colors[SchemeLast][2] = {
	[SchemeNorm] = { "#D3C6AA", "#272E33" },
	[SchemeSel] = { "#272E33", "#DBBC7F" },
	[SchemeOut] = { "#E67E80", "#272E33" },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
