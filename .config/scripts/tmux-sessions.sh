#!/bin/bash
# Based on tmux-session-dispensary by Sylvan Franklin
# https://github.com/SylvanFranklin/.config/blob/main/scripts/tmux-session-dispensary.sh
#
# Depends on skim
# https://github.com/skim-rs/skim

# Assumes an environment variable DIRS:
# WORK_DIRS=(
#     "$HOME"
#     "$HOME/wdp"
# )
#
# Usage:
# Select and open session
# tmux-sessions.sh
# tmux-sessions.sh select
#
# Select and open session (including hidden directories)
# tmux.sessions.sh select all
#
# Open/load a session in a directory
# tmux-sessions.sh open [DIRECTORY]

mapfile -t WORK_DIRS < ~/.cache/work_dirs

if [[ $1 == "open" ]]; then
    selected=$2
else
    # command array
    finder=( find "${WORK_DIRS[@]}" -maxdepth 1 -type 'd' )
    if [[ $1 == "select" && $2 != "all" ]]; then
        # disclude hidden directories
        finder+=(-not -name '.*')
    fi

    # 1. invoke finder
    # 2. replace $HOME prefix with ~ 
    # 3. launch fuzzy picker
    # 4. remove ~
    selected=$("${finder[@]}"  \
        | sed "s|^$HOME/|~/|" \
        | sk --margin 10% --color="bw" \
        | sed "s|^~/|$HOME/|")

    [[ $selected ]] && selected="$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t="$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
