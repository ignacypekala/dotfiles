#!/bin/bash

raw_path="$1"
session_id="$2"

display_path=$(tmux-name-desanitize.sh "$raw_path" | path-format.sh | path-trim.sh 50)

tmux set-environment -t "$session_id" session_display_path "$display_path"
