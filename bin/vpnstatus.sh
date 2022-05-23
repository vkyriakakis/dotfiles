#!/usr/bin/env bash

# For use with my custom vpn status polybar module

# Show the initial vpnstatus
if [[ -n $(nmcli con show --active "$1") ]];
then
	echo "VPN"
else
	echo "%{F#666}VPN%{F-}"
fi

# Then wait for vpn status change events
nmcli con monitor "$1" | while read -r line ; do
	if [[ -n $(nmcli con show --active "$1") ]];
	then
		echo "VPN"
	else
		echo "%{F#666}VPN%{F-}"
	fi
done
