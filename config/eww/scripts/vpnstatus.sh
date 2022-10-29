#!/usr/bin/env bash

# For use with my custom vpn status polybar module

print_vpn_status () {
	if [[ -n $(nmcli con show --active "$1") ]];
	then
		echo "<span foreground=\"#d2c446\" font=\"Font Awesome\"></span>"
	else
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"></span>"
	fi
}

print_vpn_status $1

# Then wait for vpn status change events
nmcli con monitor "$1" | while read -r line ; do
	print_vpn_status "$1"
done