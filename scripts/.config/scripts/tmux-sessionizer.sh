#!/bin/bash

DIRS=(
    "$HOME"
    "$HOME/Projects"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    if command -v fd >/dev/null 2>&1; then
        list=$(fd '' "${DIRS[@]}" -u --type=dir --max-depth=1 --full-path)
    else
        list=$(find "${DIRS[@]}" -mindepth 1 -maxdepth 1 -type d)
    fi

    if command -v sk >/dev/null 2>&1; then
        selected=$(echo "$list" | sed "s|^$HOME/||" | sk --margin 10% --color="bw")
    elif command -v fzf >/dev/null 2>&1; then
        selected=$(echo "$list" | sed "s|^$HOME/||" | fzf)
    else
        echo "Available directories:"
        PS3="Choose directory: "
        select choice in $(echo "$list" | sed "s|^$HOME/||"); do
            selected=$choice
            break
        done
    fi

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)
if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected" -n "$selected_name"
    tmux send-keys -t "$selected_name:1" "cd '$selected'" C-m "clear" C-m
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
