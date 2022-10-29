#!/usr/bin/env bash

# Get the default sink
pulse_info=($(pactl info | grep "Default Sink:"))
cur_sink=${pulse_info[2]}

if [ "$1" = "up" ]; then
	pactl set-sink-volume "$cur_sink" +5%
elif [ "$1" = "down" ]; then
	pactl set-sink-volume "$cur_sink" -5%
fi
