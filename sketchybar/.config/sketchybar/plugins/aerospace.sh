#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # sketchybar --set $NAME background.drawing=on
    # sketchybar --set $NAME background.drawing=on

    # padding färg
    sketchybar --set $NAME background.color=0xffff9e64

    # siffrornas färg
    sketchybar --set $NAME icon.color=0xEB1e1e2e
else
    # padding färg
    sketchybar --set $NAME background.color=0xEB1e1e2e

    # siffrornas färg
    sketchybar --set $NAME icon.color=0xffffffff
fi
