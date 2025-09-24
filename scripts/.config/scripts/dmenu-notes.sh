#!/usr/bin/env bash

folder="$HOME/notes"
choice=""

mkdir -p "$folder"

editfile() {
  file="$1"
  setsid -f alacritty -e nvim "$file" >/dev/null 2>&1
}

newnote () {
  name="$(echo "" | dmenu -c -p "Enter a name: " <&-)"
  [ -z "$name" ] && name="$(date +%F_%H-%M-%S)"
  file="$folder/$name.md"
  editfile "$file"
}

selected () {
  choice=$(echo -e "New\n$(ls -t1 "$folder")" | dmenu -c -l 5 -i -p "Choose note or create new: ")
  case "$choice" in
    New) newnote ;;
    *.md|*.txt) editfile "$folder/$choice" ;;
    *) exit ;;
  esac
}

selected

