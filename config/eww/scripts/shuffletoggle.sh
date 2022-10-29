#!/usr/bin/env bash

PLAYER="tauon"

status=$(playerctl --player=$PLAYER shuffle)
if [ $status == "On" ]; then
	playerctl --player=$PLAYER shuffle Off
elif [ $status == "Off" ]; then
	playerctl --player=$PLAYER shuffle On
fi
