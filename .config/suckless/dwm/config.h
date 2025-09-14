static const unsigned int borderpx  = 2;
static const unsigned int gappx	    = 5;
static const int showbar            = 1;
static const int topbar             = 1;

static const char *fonts[]          = { "Cascadia Mono:style=Bold:size=10:antialias=true:autohint=true" };
static const char *colors[][3]      = {
	[SchemeNorm] = { "#D3C6AA", "#272E33", "#83C092" },
	[SchemeSel]  = { "#374145", "#DBBC7F", "#A7C080" },
};

static const char *tags[] = { "1", "2", "3" };
static const Rule rules[] = {
	{ "st-256color",   NULL, NULL, 1,      0, -1 },
	{ "librewolf", 	   NULL, NULL, 1 << 1, 0, -1 }, 
	{ "steam", 	   NULL, NULL, 1 << 2, 0, -1 }, 
	{ "PrismLauncher", NULL, NULL, 1 << 2, 0, -1 },
};

static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;
static const int lockfullscreen = 1;
static const int refreshrate = 120;

static const Layout layouts[] = {
	{ "[]=",      tile },
};

#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#include "X11/XF86keysym.h"
static const Key keys[] = {
	{ MODKEY,                       XK_Return, 			spawn,          SHCMD("st") },
	{ MODKEY,                       XK_space,      			spawn,          SHCMD("dmenu_run") },
	{ MODKEY,                       XK_f,      			spawn,          SHCMD("librewolf") },
	{ MODKEY,                       XK_j,				focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,				focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,				setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,				setmfact,       {.f = +0.05} },
	{ MODKEY,			XK_q,				killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_Return,			zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_space,			togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_0,				tag,            {.ui = ~0 } },

	{ 0, 				XF86XK_AudioRaiseVolume,   	spawn, 		SHCMD("sh /home/andrew/.config/suckless/dwm/scripts/volume.sh up") },
	{ 0, 				XF86XK_AudioLowerVolume,   	spawn, 		SHCMD("sh /home/andrew/.config/suckless/dwm/scripts/volume.sh down") },

	TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2)
};

static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
