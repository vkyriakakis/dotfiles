#!/usr/bin/env bash

# User config
home_dir=$HOME

# Script data
options=("Video" "Song" "Image")

# Go to the "home" directory
cd $home_dir

# Get user option using a rofi menu
opt=$(printf "%s\n" ${options[@]} | rofi -p "DL by" -width 25 -lines 5 -dmenu -format i)

# Video URL 
if [ $opt = 0 ]; then
	$HOME/bin/vid-url-dl.sh 

# Song URL 
elif [ $opt = 1 ]; then
	$HOME/bin/song-url-dl.sh 

# Image URL
elif [ $opt = 2 ]; then
	$HOME/bin/img-url-dl.sh 
fi
