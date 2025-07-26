const unsigned short interval = 1000;
static const char unknown_str[] = "n/a";
#define MAXLEN 2048

static const struct arg args[] = {
  { run_command, 	"VOL: %s  •  ", 		"wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d%%\", $2 * 100}'" },
  { run_command, 	"Next Wallpaper: %s  •  ", 	"sh /home/andrew/.config/suckless/slstatus/scripts/wallpaper-countdown.sh" },
  { run_command,	"Age: %s Days  •  ", 		"sh -c 'echo $(( ( $(date +%s) - $(stat -c %W /) ) / 86400 ))'" },
  { run_command, 	"Layout: %s  •  ", 		"sh /home/andrew/.config/suckless/slstatus/scripts/get_layout.sh" },
  { run_command, 	"Up: %s ", 			"uptime -p | cut -d ' ' -f2-" },
};
