static const unsigned int borderpx  = 2;
static const unsigned int gappx	    = 5;
static const int showbar            = 1;
static const int topbar             = 1;

static const char *fonts[]          = { "CaskaydiaCove NFM style:SemiBold:size=11" };
static const char *colors[][3]      = {
	[SchemeNorm] = { "#D3C6AA", "#272E33", "#83C092" },
	[SchemeSel]  = { "#374145", "#DBBC7F", "#A7C080" },
};

static const char *tags[] = { "1", "2", "3" };
static const Rule rules[] = {
	{ "st-256color", "st-256color",		NULL, 	1,        0 },
	{ "librewolf", "Navigator",		NULL, 	1 << 1,	  0 }, 
	{ "PrismLauncher", "prismlauncher",	NULL, 	1 << 2,	  0 },
	{ "steam", "steamwebhelper",		NULL, 	1 << 2,   0 }, 
};

static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;
static const int lockfullscreen = 1;

static const Layout layouts[] = {
	{ "L: Tile",      tile },
};

#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#include "X11/XF86keysym.h"
static const Key keys[] = {
	{ MODKEY,           XK_Return,		     spawn,      SHCMD("st") },
	{ MODKEY,           XK_space,		     spawn,      SHCMD("dmenu_run")  },
	{ MODKEY,           XK_f,		     spawn,      SHCMD("librewolf") },
	{ MODKEY,           XK_j,      		     focusstack, {.i = +1 } },
	{ MODKEY,           XK_k,      		     focusstack, {.i = -1 } },
	{ MODKEY,           XK_h,      		     setmfact,   {.f = -0.05} },
	{ MODKEY,           XK_l,      		     setmfact,   {.f = +0.05} },
	{ MODKEY,	    XK_q,      		     killclient, {0} },
	{ MODKEY|ShiftMask, XK_Return, 		     zoom,  	 {0} },
	{ 0, 	            XF86XK_AudioRaiseVolume, spawn, 	 SHCMD("sh /home/andrew/.config/suckless/dwm/scripts/volume.sh up") },
	{ 0, 	            XF86XK_AudioLowerVolume, spawn, 	 SHCMD("sh /home/andrew/.config/suckless/dwm/scripts/volume.sh down") },
	TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2)
};
