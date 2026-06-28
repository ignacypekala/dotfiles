#!/usr/bin/env bash
# Reformat tmux session display path for a given client.
#
# Usage:
# ./update-path.sh [raw_path] [session] [client]

raw_path="$1"
session="$2"
client="$3"

tmux_width=$(tmux display-message -p -c "$session" "#{client_width}")
max_length=$(( $tmux_width * 40 / 100 ))

display_path=$(
    tmux-name-desanitize.sh "$raw_path" \
    | path-format.sh \
    | path-trim.sh $max_length
)

tmux set-environment -t "$session" session_display_path "$display_path"
tmux refresh-client -S
