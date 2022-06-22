#!/usr/bin/env bash

# User config
home_dir=$HOME
music_dir="Music"
music_dl_args="--audio-quality 10 --extract-audio --embed-metadata --embed-thumbnail --no-playlist"
video_dl_args="--audio-quality 10 --embed-subs --embed-metadata --embed-thumbnail --no-playlist"
root_dirs=("4chin" 
	        "americans" 
	        "amogus" 
	        "animals" 
	        "animus" 
	        "art" 
	        "cado" 
	        "consumers" 
	        "daily_dose" 
	        "ethnic" 
	        "eurobeat" 
	        "food" 
	        "gachimuchi" 
	        "games" 
	        "greeks"
	        "grizzly" 
	        "mashups" 
	        "morbius" 
	        "niconicodouga" 
	        "nippon"
	        "papagiorgis"
	        "pharma"
	        "sneed"
	        "technology"
	        "touhou"
	        "tradgames"
	        "Videos"
	        "vocaloid"
	        "ytpmvs"
	       )

# Script data
options=("Video-URL" "Song-URL")

# Go to the "home" directory
cd $home_dir

# Get user option using a rofi menu
opt=$(printf "%s\n" ${options[@]} | rofi -p "DL by" -width 25 -lines 5 -dmenu -format i)

# Video URL 
if [ $opt = 0 ]; then
	video_dirs=${root_dirs[@]}

	# List all the subdirectories of the root dirs
	for d in ${root_dirs[@]}; do
		video_dirs=(${video_dirs[@]} $(find $d/* -type d -not -path '*/.*'))
	done

	# Make the user select the dl directory
	video_dir=$(printf "%s\n" ${video_dirs[@]} | rofi -p "DL dir" -width 25 -dmenu)

	# If the user quits without giving an option, abort
	if [ -z "$video_dir" ]; then
		exit 0
	fi

	# Download the URL in the clipboard and notify the user
	url=$(xclip -o)

	# Get the name of the file for the notification
	vid_json=$(yt-dlp $url --dump-json)
	vid_title=$(echo $vid_json | jq .title) 

	output=$(yt-dlp $video_dl_args $url -o "$home_dir/$video_dir/%(title)s.%(ext)s" 2>&1)
	if [ $? -eq 0 ]; then
		notify-send "Download complete" "$vid_title"
	else
		error_msg=$(echo $output | grep -m 1 ERROR)
		notify-send "Download error" "$error_msg"
	fi

# Song URL 
elif [ $opt = 1 ]; then
	# Just download the song to the specified music directory
	url=$(xclip -o)

	# Get the name of the file for the notification
	vid_json=$(yt-dlp --dump-json $url)
	vid_title=$(echo $vid_json | jq .title) 

	output=$(yt-dlp $music_dl_args $url -o "$home_dir/$music_dir/%(title)s.%(ext)s" 2>&1)
	if [ $? -eq 0 ]; then
		notify-send "Download complete" "$vid_title"
	else
		error_msg=$(echo $output | grep -m 1 ERROR)
		notify-send "Download error" "$error_msg"
	fi
fi