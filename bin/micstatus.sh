#!/usr/bin/env bash

# For use with my custom mic status polybar module

# Print the initial micstatus
CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")
if pactl list sources | grep -A 10 $CURRENT_SOURCE | grep -q "Mute: yes";
then
	echo "%{F#666}%{F-}"
else
	echo ""
fi

# Then wait for mic status change events
pactl subscribe 2> /dev/null | grep --line-buffered "source #" | while read -r line ; do
	CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")
    if pactl list sources | grep -A 10 $CURRENT_SOURCE | grep -q "Mute: yes";
    then
    	echo "%{F#666}%{F-}"
	else
		echo ""
	fi
done
