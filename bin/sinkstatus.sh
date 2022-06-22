#!/usr/bin/env bash

# For use with my custom sink toggle polybar module

headset="alsa_output.usb-Logitech_Inc._Logitech_USB_Headset_H340-00.analog-stereo"
speakers="alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_Play__3_YDSB1730201001624B-00.analog-stereo"

# Show the initial sink
pulse_info=($(pactl info | grep "Default Sink:"))
cur_sink=${pulse_info[2]}
cur_sink_entry=($(pactl list sinks short | grep $cur_sink))
is_running=${cur_sink_entry[6]}

if [ $cur_sink = $headset ]; then
	if [ $is_running = "RUNNING" ]; then
		echo "%{F#d2c446}%{F-}"
	else
		echo "%{F#e1e0dc}%{F-}"
	fi
elif [ $cur_sink = $speakers ]; then
	if [ $is_running = "RUNNING" ]; then
		echo "%{F#d2c446}%{F-}"
	else
		echo "%{F#e1e0dc}%{F-}"
	fi
fi

# Wait for default sink change events
pactl subscribe 2> /dev/null | grep --line-buffered "sink" | while read -r line ; do
	pulse_info=($(pactl info | grep "Default Sink:"))
	cur_sink=${pulse_info[2]}
	cur_sink_entry=($(pactl list sinks short | grep $cur_sink))
	is_running=${cur_sink_entry[6]}

	if [ $cur_sink = $headset ]; then
		if [ $is_running = "RUNNING" ]; then
			echo "%{F#d2c446}%{F-}"
		else
			echo "%{F#e1e0dc}%{F-}"
		fi
	elif [ $cur_sink = $speakers ]; then
		if [ $is_running = "RUNNING" ]; then
			echo "%{F#d2c446}%{F-}"
		else
			echo "%{F#e1e0dc}%{F-}"
		fi
	fi
done