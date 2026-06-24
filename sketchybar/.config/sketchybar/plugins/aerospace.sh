#!/usr/bin/env bash

# Minimal dark theme for aerospace workspace indicators

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # Active workspace - subtle light gray background
    sketchybar --set $NAME background.color=0xff565f89
    sketchybar --set $NAME icon.color=0xff1a1b26
else
    # Inactive workspace - dark background
    sketchybar --set $NAME background.color=0xff24283b
    sketchybar --set $NAME icon.color=0xffa9b1d6
fi
