#!/usr/bin/env bash

# User configuration
music_dir="Music"
music_dl_args="--audio-quality 10 --extract-audio --embed-metadata --embed-thumbnail --no-playlist"

# Just download the song to the specified music directory
url=$(xclip -o)

# Get the name of the file for the notification
vid_json=$(yt-dlp --dump-json $url)
vid_title=$(echo $vid_json | jq .title) 

output=$(yt-dlp $music_dl_args $url -o "$music_dir/%(title)s.%(ext)s" 2>&1)
if [ $? -eq 0 ]; then
	notify-send "Download complete" "$vid_title"
else
	error_msg=$(echo $output | grep -m 1 ERROR)
	notify-send "Download error" "$error_msg"
fi