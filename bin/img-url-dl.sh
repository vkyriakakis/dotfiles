#!/usr/bin/env bash

# User configuration
root_dirs=("4chin" 
	        "americans" 
	        "amogus" 
	        "animals" 
	        "animus" 
	        "art" 
	        "cado" 
	        "consumers" 
	        "daily_dose"
	        "dalle" 
	        "drawangs"
	        "ethnic" 
	        "eurobeat" 
	        "food"
	        "frogs"
	        "gachimuchi" 
	        "games" 
	        "greeks"
	        "grizzly" 
	        "gigachads"
	        "mashups"
	        "me"
	        "memes"
	        "morbius"
	        "nature"
	        "niconicodouga" 
	        "nippon"
	        "papagiorgis"
	        "phd"
	        "pharma"
	        "sneed"
	        "spurdo"
	        "technology"
	        "touhou"
	        "trafficlag"
	        "tradgames"
	        "vocaloid"
	        "wallpapers"
	        "whenthe"
	        "wojaks"
	        "ytpmvs"
	       )

image_dirs=${root_dirs[@]}

# List all the subdirectories of the root dirs
for d in ${root_dirs[@]}; do
	image_dirs=(${image_dirs[@]} $(find $d/* -type d -not -path '*/.*'))
done

# Make the user select the dl directory
image_dir=$(printf "%s\n" ${image_dirs[@]} | rofi -p "DL dir" -width 25 -dmenu)

# If the user quits without giving an option, abort
if [ -z "$image_dir" ]; then
	exit 0
fi

# Download the URL in the clipboard and notify the user
url=$(xclip -o)

wget $url --directory-prefix "$image_dir/"

notify-send "Download complete" "${url##*/}"