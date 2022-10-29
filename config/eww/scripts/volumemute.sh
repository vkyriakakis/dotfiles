#!/usr/bin/env bash

# Get the default sink
pulse_info=($(pactl info | grep "Default Sink:"))
cur_sink=${pulse_info[2]}

# Toggle mute status
pactl set-sink-mute "$cur_sink" toggle