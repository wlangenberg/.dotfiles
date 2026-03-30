#!/usr/bin/env bash

tmux_alert() {
    local title=$1
    local message=$2
    tmux_clients=$(tmux list-clients -F '#{client_name}')
    # tmux_clients=$(tmux list-clients -F '#{pane_id}')
    for client in $tmux_clients; do
        # tmux display-popup -t "$pane" \
        tmux display-popup -c "$client" \
            -T " $title " \
            -w 50% -h 50% \
            "echo -e '$message'"
    done
}

send_notification() {
    local title=$1
    local message=$2

    case "$OSTYPE" in
    linux* | *bsd*)
        notify-send -t 8000 "$title" "$message"
        if [[ "$REMINDER_SOUND" == "on" ]]; then
            beep -D 1500
        elif [[ "$REMINDER_SOUND" != "off" && -n "$REMINDER_SOUND" ]]; then
            $REMINDER_SOUND 
        fi
        ;;
    darwin*)
        if [[ "$REMINDER_SOUND" != "off" ]]; then
            osascript -e 'display notification "'"$message"'" with title "'"$title"'" sound name ""'
        else
            osascript -e 'display notification "'"$message"'" with title "'"$title"'"'
        fi
        ;;
    esac
}

create_reminder() {
    local timer=$1
    local message=$2
    local title="REMINDER"
    (
        sleep $timer
        send_notification "$title" "$message"
        tmux_alert "$title" "$message"
    ) &
}

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <time> <message>"
    echo "Example: $0 30m 'Stretch your legs!'"
    exit 1
fi

create_reminder "$1" "$2"