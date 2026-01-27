#!/usr/bin/env bash

folder="$HOME/notes/daily"
mkdir -p "$folder"
todays_date=$(date -I)
filename="$todays_date.md"
file="$folder/$filename"

if [ ! -f "$file" ]; then
    echo "$(date -I)\n\n" > $file;
fi

nvim -c 'set laststatus=0' + "$file"
