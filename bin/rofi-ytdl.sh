#!/usr/bin/env bash

# User config
home_dir=$HOME
music_dir="Music"
music_dl_args="--audio-quality 10 --extract-audio --embed-metadata --embed-thumbnail"
video_dl_args="--audio-quality 10 --embed-subs --embed-metadata --embed-thumbnail"
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
options=("Video" "Song")

# Go to the "home" directory
cd $home_dir

# Get user option using a rofi menu
opt=$(printf "%s\n" ${options[@]} | rofi -p "DL by" -dmenu -format i)

# Video URL 
if [ $opt = 0 ]; then
	video_dirs=${root_dirs[@]}

	# List all the subdirectories of the root dirs
	for d in ${root_dirs[@]}; do
		video_dirs=(${video_dirs[@]} $(find $d/* -type d -not -path '*/.*'))
	done

	# Make the user select the dl directory
	video_dir=$(printf "%s\n" ${video_dirs[@]} | rofi -p "DL dir" -dmenu)

	# If the user quits without giving an option, abort
	if [ -z "$video_dir" ]; then
		exit 0
	fi

	# Download the URL in the clipboard
	yt-dlp $video_dl_args $(xclip -o) -o "$home_dir/$video_dir/[%(id)s]%(title)s.%(ext)s"

# Song URL 
elif [ $opt = 1 ]; then
	# Just download the song to the specified music directory
	yt-dlp $music_dl_args $(xclip -o) -o "$home_dir/$music_dir/%(title)s.%(ext)s"
fi