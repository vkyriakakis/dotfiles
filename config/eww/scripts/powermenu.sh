#!/usr/bin/env bash

# The desired action is supplied through the command line

eww close powermenu
eww close powermenu-closer

case $1 in
	"suspend")
		systemctl suspend
		;;
	"logout")
		loginctl terminate-session ${XDG_SESSION_ID-}
		;;
	"reboot")
		systemctl reboot
		;;
	"shutdown")
		systemctl poweroff
		;;
esac