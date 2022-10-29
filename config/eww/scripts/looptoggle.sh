#!/usr/bin/env bash

PLAYER="tauon"

status=$(playerctl --player=$PLAYER loop)
if [ $status == "Track" ]; then
	playerctl --player=$PLAYER loop None
elif [ $status == "None" ]; then
	playerctl --player=$PLAYER loop Track
fi
