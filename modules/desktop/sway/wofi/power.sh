#!/bin/sh

lock='⎋ Lock'
reboot='⏼ Reboot'
shutdown='⏻ Shutdown'
suspend='⏾ Suspend'
exitwm='⏎ Exit'

selected=$(printf "$lock\n$reboot\n$shutdown\n$suspend\n$exitwm" | wofi --conf="$HOME"/.config/wofi/power-config)

case $selected in
	$lock) swaylock ;;
	$reboot) systemctl reboot ;;
	$shutdown) systemctl poweroff ;;
	$suspend) systemctl suspend-then-hibernate ;;
	$exitwm) swaymsg exit ;;
	*) exit 1 ;;
esac
