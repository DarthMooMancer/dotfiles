static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static const char *fonts[] = {
	"CaskaydiaCove NFM style:SemiBold:size=11"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	[SchemeNorm] = { "#D3C6AA", "#272E33" },
	[SchemeSel] = { "#272E33", "#DBBC7F" },
	[SchemeOut] = { "#E67E80", "#272E33" },
};

static unsigned int lines      = 0;
static unsigned int columns    = 0;
static const char worddelimiters[] = " ";
