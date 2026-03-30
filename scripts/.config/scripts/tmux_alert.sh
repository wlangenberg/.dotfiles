
UnDo
send_notification() {
    local title=$1
    local message=$2
    case "$OSTYPE" in
    linux* | *bsd*)
/        notify-send -t 8000 "$title" "$message"
0        if [[ "$REMINDER_SOUND" == "on" ]]; then
            beep -D 1500
K        elif [[ "$REMINDER_SOUND" != "off" && -n "$REMINDER_SOUND" ]]; then
            $REMINDER_SOUND 
        fi
        ;;
    darwin*)
1        if [[ "$REMINDER_SOUND" != "off" ]]; then
d            osascript -e 'display notification "'"$message"'" with title "'"$title"'" sound name ""'
        else
V            osascript -e 'display notification "'"$message"'" with title "'"$title"'"'
        fi
        ;;
    esac
create_reminder() {
    local timer=$1
    local message=$2
    local title="REMINDER"
    (
        sleep $timer
-        send_notification "$title" "$message"
&        tmux_alert "$title" "$message"
    ) &
#if [ -z "$1" ] || [ -z "$2" ]; then
%    echo "Usage: $0 <time> <message>"
.    echo "Example: $0 5s 'Stretch your legs!'"
    exit 1
create_reminder "$1" "$2"5
+            "echo -e '$message\n\nPress ENT
       
        tmu
        # Use -t to ta
3    tmux_clients=$(tmux list-clients -F '#{pane_id}
7    # Grab the unique Pane ID for each active client (e
    local message
#!/bin/bash
tmux_alert() {
    local title=$1
    local message=$2
9    tmux_clients=$(tmux list-clients -F '#{client_name}')
#    for client in $tmux_clients; do
M        # Added a 'read' command so the popup stays open until you dismiss it
)        tmux display-popup -c "$client" \
            -T " $title " \
            -w 50% -h 50% \
             "echo -e '$message'"
    done
            "echo 
          
1    tmux list-clients -F '#{pane_id}' | while rea
    
tmux_alert() {
    local title=$1
    local message=$2
    
C    # Grab the unique Pane ID for each active client (e.g., %0, %1)
5    tmux_clients=$(tmux list-clients -F '#{pane_id}')
    
!    for pane in $tmux_clients; do
J        # Use -t to target the pane directly, bypassing the client TTY bug
'        tmux display-popup -t "$pane" \
            -T " $title " \
            -w 50% -h 50% \
C            "echo -e '$message\n\nPress ENTER to dismiss...'; read"
    done

