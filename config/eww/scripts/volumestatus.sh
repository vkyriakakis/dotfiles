#!/usr/bin/env bash

get_default_sink () {
	pulse_info=($(pactl info | grep "Default Sink:"))
	cur_sink=${pulse_info[2]}
}

print_volume_level () {
	if (( volume_level < 30 )); then
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"></span> <span foreground=\"#d2c446\">$volume_level%</span>"
	elif (( volume_level < 70 )); then
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"></span> <span foreground=\"#d2c446\">$volume_level%</span>"
	else
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"></span> <span foreground=\"#d2c446\">$volume_level%</span>"
	fi
}

get_volume_level () {
	volume_info=($(echo "$info" | head -n 2))
	volume_level=${volume_info[6]::-1}
}

# Get default sink
get_default_sink

# Get its info
pattern=$(printf "/Name: %s/{nr[NR+6];nr[NR+7]}; NR in nr" $cur_sink)
info=$(pactl list sinks | awk "$pattern")

# Check if mute
is_mute=($(echo "$info" | head -n 1))
if [ ${is_mute[1]} = "yes" ]; then
	echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"> nil</span>"
else
	# Else find the volume level
	get_volume_level

	# Depending on the volume level output a different icon is printed
	print_volume_level
fi

# Continue checking these events
pactl subscribe 2> /dev/null | grep --line-buffered "sink" | while read -r line ; do
	# Get default sink
	get_default_sink

	# Get its info
	pattern=$(printf "/Name: %s/{nr[NR+6];nr[NR+7]}; NR in nr" $cur_sink)
	info=$(pactl list sinks | awk "$pattern")

	# Check if mute
	is_mute=($(echo "$info" | head -n 1))
	if [ ${is_mute[1]} = "yes" ]; then
		echo "<span foreground=\"#e1e0dc\" font=\"Font Awesome\"> nil</span>"
		continue
	fi

	# Else find the volume level
	get_volume_level

	# Depending on the volume level output a different icon is printed
	print_volume_level
done