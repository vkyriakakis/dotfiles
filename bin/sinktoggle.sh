#!/usr/bin/env bash

# For use with my custom sink toggle polybar module

headset="alsa_output.usb-Logitech_Inc._Logitech_USB_Headset_H340-00.analog-stereo"
speakers="alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_Play__3_YDSB1730201001624B-00.analog-stereo"

# Find the current sink and toggle it
cur_sink=($(pactl info | grep "Default Sink:"))

if [ ${cur_sink[2]} = $headset ]; then
	pacmd set-default-sink $speakers
elif [ ${cur_sink[2]} = $speakers ]; then
	pacmd set-default-sink $headset
fi