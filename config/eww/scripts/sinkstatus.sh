#!/usr/bin/env bash

print_status () {
	# The provided argument is the icon to be printed
	if [ $is_running = "RUNNING" ]; then
		echo "<span foreground=\"#d2c446\" font=\"Font Awesome\">$1</span>"
	else
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\">$1</span>"
	fi
} 

get_default_sink () {
	pulse_info=($(pactl info | grep "Default Sink:"))
	cur_sink=${pulse_info[2]}
}

get_running_status () {
	cur_sink_entry=($(pactl list sinks short | grep $cur_sink))
	is_running=${cur_sink_entry[6]}
}

# For use with my custom sink toggle polybar module

headset="alsa_output.usb-Logitech_Inc._Logitech_USB_Headset_H340-00.analog-stereo"
speakers="alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_Play__3_YDSB1730201001624B-00.analog-stereo"

# Show the initial sink
get_default_sink
get_running_status

if [ $cur_sink = $headset ]; then
	print_status ""
elif [ $cur_sink = $speakers ]; then
	print_status ""
fi

# Wait for default sink change events
pactl subscribe 2> /dev/null | grep --line-buffered "sink" | while read -r line ; do
	get_default_sink
	get_running_status

	if [ $cur_sink = $headset ]; then
		print_status ""
	elif [ $cur_sink = $speakers ]; then
		print_status ""
	fi
done