#!/usr/bin/env bash

workspaces=$(i3-msg -t get_workspaces)

# Make all the active workspace buttons visible
active=$(echo "$workspaces" | jq '.[] | select(.id).num')
for ws in {1..10}
do
	var_name=$(printf "ws%s_visible" $ws)
	if echo "$active" | grep -qw "$ws"; then
		eww update $var_name=true
	else
		eww update $vr_name=false
	fi
done

# Notify eww about the focused workspace
focused=$(echo "$workspaces" | jq '.[] | select(.focused).num')

# This isn't done through eww update bc I want
# this script to be executed by an appropriate defpoll
eww update focused=$focused

# Make all urgent workspaces get the urgent class
urgent=$(echo "$workspaces" | jq '.[] | select(.urgent).num')
for ws in {1..10}
do
	var_name=$(printf "ws%s_urgent" $ws)
	if echo "$active" | grep -qw "$ws"; then
		eww update $var_name=true
	else
		eww update $var_name=false
	fi
done

# Do this indefinitely
i3-msg -m -t subscribe "[ \"workspace\" ]" | while read -r line; do
	# TODO -> "empty" "focus" "init" cases to make more performant
	change=$(echo "$line" | jq '.["change"]')

	if [ "$change" = "\"init\"" ] || [ "$change" = "\"focus\"" ]; then
		num=$(echo "$line" | jq '.["current"]["num"]')
		var_name=$(printf "ws%s_visible" $num)

		# Make workspace visible
		eww update $var_name=true

		# New workspace is focused
		focused=$num
		eww update focused=$focused
 	elif [ "$change" = "\"empty\"" ]; then
 		num=$(echo "$line" | jq '.["current"]["num"]')
		var_name=$(printf "ws%s_visible" $num)

		if [ "$focused" !=  "$num" ]; then
			eww update $var_name=false
		fi
	fi
done