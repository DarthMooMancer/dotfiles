const unsigned int interval = 1000;
static const char unknown_str[] = "n/a";
#define MAXLEN 2048

/*
 * function            description                     argument (example)
 *
 * battery_perc        battery percentage              battery name (BAT0)
 * battery_remaining   battery remaining HH:MM         battery name (BAT0)
 * battery_state       battery charging state          battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * cat                 read arbitrary file             path
 * cpu_freq            cpu frequency in MHz            NULL
 * cpu_perc            cpu usage in percent            NULL
 * datetime            date and time                   format string (%F %T)
 * disk_free           free disk space in GB           mountpoint path (/)
 * disk_perc           disk usage in percent           mountpoint path (/)
 * disk_total          total disk space in GB          mountpoint path (/)
 * disk_used           used disk space in GB           mountpoint path (/)
 * kernel_release      `uname -r`                      NULL
 * keyboard_indicators caps/num lock indicators        format string (c?n?)
 *                                                     see keyboard_indicators.c
 * ram_free            free memory in GB               NULL
 * ram_perc            memory usage in percent         NULL
 * ram_total           total memory size in GB         NULL
 * ram_used            used memory in GB               NULL
 * run_command         custom shell command            command (echo foo)
 * uptime              system uptime                   NULL
 * username            username of current user        NULL
 * vol_perc            OSS/ALSA volume in percent      mixer file (/dev/mixer)
 */

static const struct arg args[] = {
  /* function format          argument */
  { run_command, 	"VOL: %s  •  ", 		"wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d%%\", $2 * 100}'" },
  { run_command, 	"Next Wallpaper: %s  •  ", 	"sh /home/andrew/.config/suckless/slstatus/scripts/wallpaper-countdown.sh" },
  { run_command,	"Age: %s Days  •  ", 		"sh -c 'echo $(( ( $(date +%s) - $(stat -c %W /) ) / 86400 ))'" },
  { run_command, 	"Layout: %s  •  ", 		"sh /home/andrew/.config/suckless/slstatus/scripts/get_layout.sh" },
  { run_command, 	"Up: %s ", 			"uptime -p | cut -d ' ' -f2-" },
};
