#!/usr/bin/env bash

# For use with my custom sink toggle polybar module

headset="alsa_output.usb-Logitech_Inc._Logitech_USB_Headset_H340-00.analog-stereo"
speakers="alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_Play__3_YDSB1730201001624B-00.analog-stereo"

# Show the initial sink
cur_sink=($(pactl list sinks short | grep RUNNING))

if [ ${cur_sink[1]} = $headset ]; then
	echo "%{F#d2c446}%{F-}"
elif [ ${cur_sink[1]} = $speakers ]; then
	echo "%{F#d2c446}%{F-}"
else
	echo "%{F#e1e0dc}%{F-}"
fi

# Wait for default sink change events
pactl subscribe 2> /dev/null | grep --line-buffered "sink #" | while read -r line ; do
	cur_sink=($(pactl list sinks short | grep RUNNING))
	if [ ${cur_sink[1]} = $headset ]; then
		echo "%{F#d2c446}%{F-}"
	elif [ ${cur_sink[1]} = $speakers ]; then
		echo "%{F#d2c446}%{F-}"
	else
		echo "%{F#e1e0dc}%{F-}"
	fi
done