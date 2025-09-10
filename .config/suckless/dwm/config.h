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
	{ "PrismLauncher", "prismlauncher",	NULL, 	1 << 2,	  0,   -1 },
	{ "librewolf", "Navigator",	NULL, 	1 << 1,	  0,   -1 }, 
	{ "steam", "steamwebhelper",		NULL, 	1 << 2,   0,   -1 }, 
	{ "st-256color", "st-256color",		NULL, 	1,        0,   -1 },
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
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browsercmd[]  = { "librewolf", NULL };

#include "X11/XF86keysym.h"
static const Key keys[] = {
	{ MODKEY,                       XK_Return, 			spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_space,      			spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_f,      			spawn,          {.v = browsercmd } },
	{ MODKEY|ShiftMask,             XK_l,      			spawn,          SHCMD("sh /home/andrew/.config/suckless/dmenu/scripts/powermenu.sh") },
	{ MODKEY,                       XK_h,				focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_l,				focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_j,				setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_k,				setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_i,				incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,				incnmaster,     {.i = -1 } },
	{ MODKEY,			XK_q,				killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_Return,			zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_space,			togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_0,				tag,            {.ui = ~0 } },

	{ 0, 				XF86XK_AudioRaiseVolume,   	spawn, 		SHCMD("sh /home/andrew/.config/suckless/dwm/scripts/volume.sh up") },
	{ 0, 				XF86XK_AudioLowerVolume,   	spawn, 		SHCMD("sh /home/andrew/.config/suckless/dwm/scripts/volume.sh down") },

	TAGKEYS(                        XK_1,						0 )
	TAGKEYS(                        XK_2,						1 )
	TAGKEYS(                        XK_3,						2 )
	TAGKEYS(                        XK_4,						3 )
};

static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
