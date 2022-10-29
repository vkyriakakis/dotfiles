#!/usr/bin/env bash

# For use with my custom mic status polybar module

print_mic_status () {
	CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")
	if pactl list sources | grep -A 10 $CURRENT_SOURCE | grep -q "Mute: yes";
	then
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"></span>"
	else
		echo "<span foreground=\"#d2c446\" font=\"Font Awesome\"></span>"
	fi
}

print_mic_status

# Then wait for mic status change events
pactl subscribe 2> /dev/null | grep --line-buffered "source #" | while read -r line ; do
	print_mic_status
done
