#!/bin/bash

raw_path="$1"
session="$2"

display_path=$(
    tmux-name-desanitize.sh "$raw_path" \
    | path-format.sh \
    | path-trim-relative.sh 0.4 20
)

tmux set-environment -t "$session" session_display_path "$display_path"
tmux refresh-client -S
