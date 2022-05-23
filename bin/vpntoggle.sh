#!/usr/bin/env bash

# For use with my custom vpn status polybar module
if [[ -n $(nmcli con show --active "$1") ]];
then
	nmcli con down "$1"
else
	nmcli con up "$1"
fi